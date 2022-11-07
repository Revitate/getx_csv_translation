import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';

class ParseError extends Error {
  final String message;
  ParseError(this.message);

  @override
  String toString() => '[Parse CSV Error] $message';
}

class DuplicateError extends Error {
  final String message;
  final String key;
  DuplicateError(this.message, this.key);

  @override
  String toString() => '[Parse CSV Error] $message';
}

genKeysFromCSV(File csvFile) async {
  final csvInput = csvFile.openRead();
  final csv = await csvInput
      .transform(utf8.decoder)
      .transform(const CsvToListConverter(
        shouldParseNumbers: false,
      ))
      .toList();

  final headers = csv[0]
      .cast<String>()
      .map(_uniformizeKey)
      .takeWhile((x) => x.isNotEmpty)
      .toList();
  final data = csv
      .sublist(1)
      .cast<List>()
      .takeWhile((x) => x.isNotEmpty)
      .toList();

  if (headers[0] != "key") {
    throw ParseError(
      'Generator cannot parse',
    );
  }
  final locales = headers.sublist(1);

  final Map<String, Map<String, String>> keys = {};

  for (final r in data) {
    final row = r.cast<String>().map(_uniformizeKey).toList();
    final key = row[0];
    if (row.length < headers.length) {
      throw ParseError(
        'Generator cannot parse row `$key`.',
      );
    }
    for (var i = 0; i < locales.length; i++) {
      final locale = locales[i];
      final value = row[i + 1];
      if (keys[locale] == null) {
        keys[locale] = {
          key: value,
        };
      } else {
        if (keys[locale]![key] != null) {
          throw DuplicateError('Generator found duplicate key `$key`.', key);
        }
        keys[locale]![key] = value;
      }
    }
  }
  return keys;
}

String _uniformizeKey(String key) {
  key = key.trim().replaceAll('\n', '');
  return key;
}
