import 'package:args/args.dart';

import 'src/build.dart';
import 'src/watch.dart';

void main(List<String> arguments) {
  if (arguments.isEmpty) return;
  // arguments.forEach(print);

  final ArgParser parser = ArgParser();
  parser.addCommand(
      'build',
      ArgParser()
        ..addOption('csvPath')
        ..addOption('targetPath')
        ..addOption('singleQuote', defaultsTo: 'true'));
  parser.addCommand(
      'watch',
      ArgParser()
        ..addOption('csvPath')
        ..addOption('targetPath')
        ..addOption('singleQuote', defaultsTo: 'true'));

  ArgResults results = parser.parse(arguments);
  if (results.command?.name == 'build') {
    runBuild(
      results.command?['csvPath'],
      results.command?['targetPath'],
      singleQuote: results.command?['singleQuote'] == 'true',
    );
  } else if (results.command?.name == 'watch') {
    runWatch(
      results.command?['csvPath'],
      results.command?['targetPath'],
      singleQuote: results.command?['singleQuote'] == 'true',
    );
  }
}
