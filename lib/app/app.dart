import 'package:cleanarch/app/app_prefs.dart';
import 'package:cleanarch/app/di.dart';
import 'package:cleanarch/presentation/resources/routes_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/resources/theme_manager.dart';

class MyApp extends StatefulWidget {
  // default constructor -> when we are creating a singleton of this class  the default constructor must be removed
  //const MyApp({Key? key}) : super(key: key);

  // private named constructor
  const MyApp._internal();

  // create a singleton of the private constructor
  static const MyApp instance = MyApp._internal();

  // factory for the class instance
  factory MyApp() => instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  final AppPreferences _appPreferences = instance<AppPreferences>();

  // maybe user change the language of the device to Arabic and off the device, the second time user open the device it need to show Arabic text to user
  @override
  void didChangeDependencies() {
    _appPreferences.getLocale().then((locale) => {
      context.setLocale(locale)
    });
    super.didChangeDependencies();
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.splashRoute,
        debugShowCheckedModeBanner: false,
        theme: getApplicationTheme());
  }
}
