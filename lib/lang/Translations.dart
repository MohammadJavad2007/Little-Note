import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        // 'ko_KR': {
        //   'greeting': '안녕하세요',
        // },
        // 'ja_JP': {
        //   'greeting': 'こんにちは',
        // },
        'en_US': {
          'Notes': 'Notes',
          'Add a note': 'Add a note',
          'Save your changes or discard them?':
              'Save your changes or discard them?',
          'Cancle': 'Cancel',
          'Discard': 'Discard',
          'Save': 'Save',
          'Title': 'Title',
          'Description': 'Description',
          'Field can\'t be empty': 'Field can\'t be empty',
          'Update a note': 'Update a note',
          'Note Pad': 'Note Pad',
          'English language': 'English language',
          'Do you really want to delete the note?':
              'Do you really want to delete the note?',
          'Delete': 'Delete',
          'Write Your First Note': 'Write Your First Note',
          'ADD NEW NOTE': 'ADD NEW NOTE',
        },
        'fa_IR': {
          'Notes': 'یادداشت ها',
          'Add a note': 'یک یادداشت اضافه کنید',
          'Save your changes or discard them?':
              'تغییرات خود را ذخیره کنید یا از آنها صرف نظر کنید؟',
          'Cancle': 'لغو',
          'Discard': 'پاک',
          'Save': 'خیره',
          'Title': 'عنوان',
          'Description': 'متن',
          'Field can\'t be empty': 'فیلد نمی تواند خالی باشد',
          'Update a note': 'یک یادداشت را به روز کنید',
          'Note Pad': 'دفترچه یادداشت',
          'English language': 'زبان فارسی',
          'Do you really want to delete the note?':
              'آیا واقعاً می خواهید یادداشت را حذف کنید؟',
          'Delete': 'حذف',
          'Write Your First Note': 'اولین یادداشت خود را بنویسید',
          'ADD NEW NOTE': 'یادداشت جدید',
        },
      };
}









// import 'dart:convert';

// import 'package:flutter/material.dart';
// // import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter/services.dart' show rootBundle;


// class Translations {

//   late Map localizationValues;

//   Future load(Locale locale) async {
//     String jsonContent = await rootBundle.loadString('lib/lang/${locale.languageCode}.json');
//     localizationValues = jsonDecode(jsonContent);
//     print(localizationValues['title']);
//   }
  
//   static Translations? of(BuildContext context) {
//     return Localizations.of(context, Translations);
//   }

//   String text(String key) {
//     if(localizationValues['key'] == '') {
//       return "Error $key";
//     } else {
//       return localizationValues['key'];
//     }
//   }
// }

// class AppLocalizationsDelegate extends LocalizationsDelegate<Translations> {
//   @override
//   bool isSupported(Locale locale) {
//     // TODO: implement isSupported
//     return ['fa','en'].contains(locale.languageCode);
//   }

//   @override
//   Future<Translations> load(Locale locale) async {
//     // TODO: implement load
//     Translations translations = new Translations();
//     await translations.load(locale);
//     return translations;
//   }

//   @override
//   bool shouldReload(covariant LocalizationsDelegate<Translations> old) {
//     // TODO: implement shouldReload
//     return false;
//   }

// }