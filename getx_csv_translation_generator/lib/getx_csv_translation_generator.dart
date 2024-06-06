library getx_csv_translation_generator;

import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:getx_csv_translation/getx_csv_translation.dart';
import 'package:getx_csv_translation_generator/keys.dart';
import 'package:getx_csv_translation_generator/utils.dart';
import 'package:source_gen/source_gen.dart';

class GetXCSVTranslationGenerator
    extends GeneratorForAnnotation<GetXCSVTranslation> {
  final BuilderOptions options;
  const GetXCSVTranslationGenerator(this.options);

  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    if (element is! ClassElement) {
      final name = element.name;
      throw InvalidGenerationSourceError(
        'Generator cannot target `$name`.',
        todo: 'Remove the GetXCSVTranslation annotation from `$name`.',
        element: element,
      );
    }
    final csvPath = options.config['csv_path'] ?? 'translations.csv';
    final csvInput = File(csvPath);
    if (!csvInput.existsSync()) {
      throw InvalidGenerationSourceError(
        'Generator cannot find csv file `$csvPath`.',
        todo: 'Check path of `$csvPath`.',
        element: element,
      );
    }
    try {
      final keys = await genKeysFromCSV(csvInput);
      var jsonData = json.encode(keys).replaceAll('\\\\n', '\\n');
      final singleQuote = options.config['single_quote'] ?? true;
      if (singleQuote) {
        jsonData = formatSingleQuote(jsonData);
      }

      String localization = genClassFromKeys(
        keys,
        className: options.config['localization_name'],
      );

      return '''const \$keys = $jsonData;\n\n$localization''';
    } on ParseError catch (_) {
      throw InvalidGenerationSourceError(
        'Generator cannot find csv file `$csvPath`.',
        todo: 'Check path of `$csvPath`.',
        element: element,
      );
    } on DuplicateError catch (e) {
      throw InvalidGenerationSourceError(
        'Generator found duplicate key `${e.key}`.',
        todo: 'Change duplicate key `${e.key}`.',
        element: element,
      );
    } catch (e) {
      stdout.writeln(e);
      throw InvalidGenerationSourceError(
        'Generator cannot generate.',
        element: element,
      );
    }
  }
}
