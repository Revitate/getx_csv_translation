import 'dart:io';

import 'package:watcher/watcher.dart';

import 'build.dart';

runWatch(
  String? csvPath,
  String? targetPath, {
  bool? singleQuote,
}) async {
  final ensureCsvPath = csvPath ?? './translations.csv';

  final ensureTargetPath = targetPath ?? './lib/translations.dart';

  try {
    await runBuild(csvPath, targetPath);
  } catch (e) {
    stdout.writeln(e);
  }

  // watch pubspec.yaml
  FileWatcher watcher = FileWatcher(ensureCsvPath);
  watcher.events.listen((event) async {
    switch (event.type) {
      case ChangeType.ADD:
      case ChangeType.REMOVE:
        break;
      case ChangeType.MODIFY:
        try {
          await runBuild(
            ensureCsvPath,
            ensureTargetPath,
            singleQuote: singleQuote,
          );
        } catch (e) {
          stdout.writeln(e);
        }

        break;
    }
  });
}
