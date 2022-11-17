import 'package:cleanarch/presentation/resources/language_manager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_LANG = 'PREFS_KEY_LANG';

class AppPreferences {

  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  //get language from the shared preferences of the device -> maybe user set a language rather than English
  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(PREFS_KEY_LANG);

    // it means user set a language for the devices
    if (language != null && language.isNotEmpty) {
      return language;
    }
    // default language of the device is English
    else {
      return LanguageType.ENGLISH.getValue();
    }
  }

  // when user change the language of the device
  Future<void> setLanguageChanged() async {
    String currentLanguage = await getAppLanguage();
    if (currentLanguage == LanguageType.ARABIC.getValue()) {
      // save prefs with English lang
      _sharedPreferences.setString(
          PREFS_KEY_LANG, LanguageType.ENGLISH.getValue());
    } else {
      // save prefs with Arabic lang
      _sharedPreferences.setString(
          PREFS_KEY_LANG, LanguageType.ARABIC.getValue());
    }
  }

  Future<Locale> getLocale() async {
    String currentLanguage = await getAppLanguage();
    if (currentLanguage == LanguageType.ARABIC.getValue()) {
      // return Arabic language
      return ARABIC_LOCALE;
    } else {
      // return English language
      return ENGLISH_LOCALE;
    }
  }
}
