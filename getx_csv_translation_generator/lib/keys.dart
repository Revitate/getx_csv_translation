import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:csv/csv_settings_autodetection.dart';

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

Future<Map<String, Map<String, String>>> genKeysFromCSV(File csvFile) async {
  final csvInput = csvFile.openRead();
  final csv = await csvInput
      .transform(utf8.decoder)
      .transform(const CsvToListConverter(
        shouldParseNumbers: false,
        csvSettingsDetector: FirstOccurrenceSettingsDetector(
          eols: ['\r\n', '\n'],
        ),
      ))
      .toList();

  final headers = csv[0]
      .cast<String>()
      .map(_uniformizeKey)
      .takeWhile((x) => x.isNotEmpty)
      .toList();
  final data =
      csv.sublist(1).cast<List>().takeWhile((x) => x.isNotEmpty).toList();

  if (headers[0] != 'key') {
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

String genClassFromKeys(
  Map<String, Map<String, String>> keys, {
  String className = 'AppLocalization',
}) {
  var keysMap = keys.isEmpty ? {} : keys.values.first;

  String localization = '';
  keysMap.forEach((key, value) {
    List<String> keyName = key.split(RegExp(r'[._-]'));
    String name = '';
    if (keyName.isNotEmpty) {
      name = keyName.first;
      keyName.removeAt(0);

      for (var element in keyName) {
        name += _capitalize(element);
      }
    }
    var matches = RegExp(r'@(\w+)').allMatches(value);
    var results = matches.map((match) => match.group(1)).toSet().toList();

    if (localization.contains(' $name ')) {
      throw Exception(
          '\n\n*** Generator found duplicate name `$name`, key `$key`. ***\n\n');
    }

    if (results.isEmpty) {
      localization += '  static String get $name => \'$key\'.tr;\n';
    } else {
      String variable = '';
      String params = '';
      for (var result in results) {
        variable += 'required String $result,\n';
        params += '\'$result\': $result,\n';
      }
      localization += '''  static String $name ({
    $variable
  }) => '$key'.tr.trParams({
    $params
  });\n''';
    }
  });
  return '''class $className {
  $localization
}
''';
}

String _capitalize(String value) {
  if (value.isEmpty) {
    return value;
  }

  if (value.length == 1) return value.toUpperCase();

  return '${value[0].toUpperCase()}${value.substring(1)}';
}
