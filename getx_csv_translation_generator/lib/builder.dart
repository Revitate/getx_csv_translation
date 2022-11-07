import 'package:build/build.dart';
import 'package:getx_csv_translation_generator/getx_csv_translation_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder getXTranslationBuilder(BuilderOptions options) => SharedPartBuilder(
    [GetXCSVTranslationGenerator(options)], 'getx_csv_translation');
