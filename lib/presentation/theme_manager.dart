
import 'package:cleanarch/presentation/color_manager.dart';
import 'package:flutter/material.dart';

// this function will be inside of application class
// because we need to apply one theme through all the app to our application
ThemeData getApplicationTheme() {
  return ThemeData(

    // main colors of the app
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryOpacity70,
    primaryColorDark: ColorManager.darkPrimary,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ColorManager.grey), // instead of using accentColor
    disabledColor: ColorManager.grey1,  // will be used in case of disabled button for example

    // card view theme

    // app bar theme

    // button theme

    // text theme

    // input decoration theme

  );
}