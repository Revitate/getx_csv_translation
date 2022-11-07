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

Annotations for the getx_csv_translation_generator package.

## Usage

create `translations.dart`
```dart
import 'package:getx_csv_translation/getx_csv_translation.dart';
import 'package:get/get.dart';

part 'translations.g.dart';

@GetXCSVTranslation()
class GetXCSVTranslations extends Translations {

  @override
  Map<String, Map<String, String>> get keys => $keys;
```
