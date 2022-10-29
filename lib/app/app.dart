import 'package:cleanarch/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.splashRoute,
        debugShowCheckedModeBanner: false,
        theme: getApplicationTheme());
  }
}
