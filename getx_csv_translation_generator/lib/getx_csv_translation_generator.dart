library getx_csv_translation_generator;

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

class GetXCSVTranslationGenerator
    extends GeneratorForAnnotation<GetXCSVTranslation> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final csvPath = annotation.read('csvPath').stringValue;
    return '';
  }
}
