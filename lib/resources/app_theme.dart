import 'package:flutter/material.dart';
import 'package:flutter_meels_app/resources/color_manager.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: ColorManager.primary,
    scaffoldBackgroundColor: ColorManager.white,
    brightness: Brightness.light,
  );
}
