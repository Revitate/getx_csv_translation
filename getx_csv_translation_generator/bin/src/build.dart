import 'dart:convert';
import 'package:getx_csv_translation_generator/utils.dart';
import 'package:path/path.dart';
import 'dart:io';

import 'package:getx_csv_translation_generator/keys.dart';

import 'format.dart';

runBuild(
  String? csvPath,
  String? targetPath, {
  singleQuote = true,
}) async {
  File f = File(csvPath ?? './translations.csv');
  if (!f.existsSync()) {
    stdout.writeln('Can not find csv file: $csvPath');
    return;
  }

  stdout.writeln('Building...');
  final keys = await genKeysFromCSV(f);
  var jsonData = json.encode(keys);
  if (singleQuote) {
    jsonData = formatSingleQuote(jsonData);
  }

  final ensureTargetPath = targetPath ?? './lib/translations.dart';
  final targetFileName = basenameWithoutExtension(ensureTargetPath);
  final generatedFileName = '$targetFileName.g.dart';

  File genFile = File(join(dirname(ensureTargetPath), generatedFileName));
  final content = '''// GENERATED CODE - DO NOT MODIFY BY HAND

part of '$targetFileName.dart';

// **************************************************************************
// GetXCSVTranslationGenerator
// **************************************************************************

const \$keys = $jsonData;
''';
  genFile.writeAsStringSync(formatDartContent(content));
  stdout.writeln('Build finished.');
}
