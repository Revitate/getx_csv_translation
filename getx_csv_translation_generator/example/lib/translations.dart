import 'package:getx_csv_translation/getx_csv_translation.dart';
import 'package:get/get.dart';

part 'translations.g.dart';

@GetXCSVTranslation()
class GetXCSVTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => $keys;
}
