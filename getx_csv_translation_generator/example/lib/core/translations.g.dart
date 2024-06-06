// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translations.dart';

// **************************************************************************
// GetXCSVTranslationGenerator
// **************************************************************************

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
