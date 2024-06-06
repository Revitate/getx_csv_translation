<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

[GetX](https://pub.dev/packages/get#internationalization) Translation code generator from CSV.

## Install

Add the following to your pubspec.yaml:

```
dependencies:
  getx_csv_translation: <latest>

dev_dependencies:
  build_runner: <latest>
  getx_csv_translation_generator: <latest>
```

## Usage

1. Create `translations.csv` ([example](./example/translations.csv))

| key   | en_US      | th_TH       | \<locale>      |
| ----- | ---------- | ----------- | -------------- |
| test  | test       | ทดสอบ       | \<translation> |
| param | test @name | ทดสอบ @name | ...            |

2. Create `lib/translations.dart`

```dart
import 'package:getx_csv_translation/getx_csv_translation.dart';
import 'package:get/get.dart';

part 'translations.g.dart';

@GetXCSVTranslation()
class GetXCSVTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => $keys;
}
```

3. Generate translations

   3.1 with `build_runner`

```
flutter packages pub run build_runner build
```

3.2 with CLI

```
flutter pub run getx_csv_translation_generator build --csvPath <path to translation(optional)> --targetPath <path to translations.dart(optional)>
```

```
flutter pub run getx_csv_translation_generator watch --csvPath <path to translation(optional)> --targetPath <path to translations.dart(optional)>
```

4. Configure GetX app

```dart
return GetMaterialApp(
    translations: GetXCSVTranslations(), // your translations
    ...
);
```

## How to use AppLocalization class

The `AppLocalization` class provides static getter methods for accessing the translations. For example, `AppLocalization.test` returns the translation for the key `'test'`. Similarly, `AppLocalization.test2` returns the translation for the key `'test2'`. The class also includes a static method named `test4DialogDescription` that takes two required parameters (`value` and `coins`) and returns a translation based on those parameters.

Overall, this code represents a localization mechanism where translations for different languages are stored in a map, and the `AppLocalization` class provides convenient methods to access those translations.

```dart

const $keys = {
  'en': {
    'test': 'Te\nst',
    'test2': 'Te,nst',
    'test3': '"Tenst"',
    'test4.dialog.title.makeText': '"Test Text, "',
    'test4.dialog.description': '"(@value) make more money @coins "',
    'test5.title': '"Head @value is @value "'
  },
  'th': {
    'test': 'ทด\nสอบ',
    'test2': 'ทด,สอบ',
    'test3': '"ทดสอบ"',
    'test4.dialog.title.makeText': '"ทดสอบ ข้อความ, "',
    'test4.dialog.description': '"(@value) ทำเงินเพิ่มขึ้น @coins "',
    'test5.title': '"หัวข้อ @value เป็น @value "'
  }
};

class AppLocalization {
  static String get test => 'test'.tr;
  static String get test2 => 'test2'.tr;
  static String get test3 => 'test3'.tr;
  static String get test4DialogTitleMakeText =>
      'test4.dialog.title.makeText'.tr;
  static String test4DialogDescription({
    required String value,
    required String coins,
  }) =>
      'test4.dialog.description'.tr.trParams({
        'value': value,
        'coins': coins,
      });
  static String test5Title({
    required String value,
  }) =>
      'test5.title'.tr.trParams({
        'value': value,
      });
}
```

### Example use class AppLocalization

1. Import the AppLocalization class in the file where you want to use it:
``` dart
import 'path_to_your_file/translations.dart';
```

2. Use the static getters of the AppLocalization class to get the translated strings:
``` dart
String testTranslation = AppLocalization.test;
String test2Translation = AppLocalization.test2;
```

3. If you have dynamic translations that require parameters, you can pass them as arguments:
``` dart
String dialogDescription = AppLocalization.test4DialogDescription(
  value: '100',
  coins: '50',
);
```
This will return the translation for 'test4.dialog.description' with 'value' and 'coins' replaced by '100' and '50', respectively.

## Build Configuraion

Aside from setting arguments on the associated annotation classes, you can also configure code generation by setting values in build.yaml.

```
targets:
  $default:
    builders:
      getx_csv_translation_generator|getx_csv_translation:
        options:
          # The default value for each is listed.
          csv_path: ./translation.csv
          single_quote: true
          localization_name: AppLocalization
```


