import 'dart:convert';
import 'dart:io';

import 'package:getx_csv_translation_generator/keys.dart';
import 'package:path/path.dart';
import 'package:watcher/watcher.dart';

import 'build.dart';
import 'format.dart';

runWatch(
  String? _csvPath,
  String? _targetPath,
) async {
  final csvPath = _csvPath ?? './translations.csv';

  final targetPath = _targetPath ?? './lib/translations.dart';

  try {
    await runBuild(csvPath, targetPath);
  } catch (e) {
    stdout.writeln(e);
  }

  // watch pubspec.yaml
  FileWatcher watcher = FileWatcher(csvPath);
  watcher.events.listen((event) async {
    switch (event.type) {
      case ChangeType.ADD:
      case ChangeType.REMOVE:
        break;
      case ChangeType.MODIFY:
        try {
          await runBuild(csvPath, targetPath);
        } catch (e) {
          stdout.writeln(e);
        }

        break;
    }
  });
}
