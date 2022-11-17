import 'package:flutter/material.dart';

enum LanguageType { ENGLISH, ARABIC }

const String ARABIC = 'ar';
const String ENGLISH = 'en';

// it should be the same as json file
const Locale ARABIC_LOCALE = Locale('ar','SA');
const Locale ENGLISH_LOCALE = Locale('en','US');

const String ASSETS_PATH_LOCALIZATIONS = 'assets/translations';

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.ENGLISH:
        return ENGLISH;
      case LanguageType.ARABIC:
        return ARABIC;
    }
  }
}
