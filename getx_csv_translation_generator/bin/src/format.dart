import 'package:dart_style/dart_style.dart';

String formatDartContent(String content) {
  try {
    var formatter = DartFormatter();
    return formatter.format(content);
  } catch (e) {
    return content;
  }
}
