import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart' show rootBundle;


class Translations {

  late Map localizationValues;

  Future load(Locale locale) async {
    String jsonContent = await rootBundle.loadString('lib/lang/${locale.languageCode}.json');
    localizationValues = jsonDecode(jsonContent);
    print(localizationValues['title']);
  }
  
  static Translations? of(BuildContext context) {
    return Localizations.of(context, Translations);
  }

  String text(String key) {
    if(localizationValues['key'] == '') {
      return "Error $key";
    } else {
      return localizationValues['key'];
    }
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<Translations> {
  @override
  bool isSupported(Locale locale) {
    // TODO: implement isSupported
    return ['fa','en'].contains(locale.languageCode);
  }

  @override
  Future<Translations> load(Locale locale) async {
    // TODO: implement load
    Translations translations = new Translations();
    await translations.load(locale);
    return translations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<Translations> old) {
    // TODO: implement shouldReload
    return false;
  }

}