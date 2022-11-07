import 'dart:convert';
import 'package:path/path.dart';
import 'dart:io';

import 'package:getx_csv_translation_generator/keys.dart';

import 'format.dart';

runBuild(
  String? csvPath,
  String? targetPath,
) async {
  File f = File(csvPath ?? './translations.csv');
  if (!f.existsSync()) {
    stdout.writeln('Can not find csv file: $csvPath');
    return;
  }

  stdout.writeln('Building...');
  final keys = await genKeysFromCSV(f);

  final ensureTargetPath = targetPath ?? './lib/translations.dart';
  final targetFileName = basenameWithoutExtension(ensureTargetPath);
  final generatedFileName = '$targetFileName.g.dart';

  File genFile = File(join(dirname(ensureTargetPath), generatedFileName));
  final content = '''// GENERATED CODE - DO NOT MODIFY BY HAND

part of '$targetFileName.dart';

// **************************************************************************
// GetXCSVTranslationGenerator
// **************************************************************************

const \$keys = ${json.encode(keys)};
''';
  genFile.writeAsStringSync(formatDartContent(content));
  stdout.writeln('Build finished.');
}
