import 'package:cleanarch/app/di.dart';
import 'package:cleanarch/presentation/resources/language_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // first ensure that the localization is init
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(EasyLocalization(
      supportedLocales: const [ENGLISH_LOCALE, ARABIC_LOCALE],
      path: ASSETS_PATH_LOCALIZATIONS,
      child: Phoenix(child: MyApp())));
}
