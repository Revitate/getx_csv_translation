import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

Builder flutterSheetLocalization(BuilderOptions options) =>
    SharedPartBuilder([SheetLocalizationGenerator()], 'getx_csv_translation');
