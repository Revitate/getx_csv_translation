# getx_csv_translation

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

1. Create `translations.csv` ([example](./getx_csv_translation_generator/example/translations.csv))

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
```
