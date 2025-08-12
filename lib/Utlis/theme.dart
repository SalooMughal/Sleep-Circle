import 'package:flutter/material.dart';

import '../Widgets/App_Font.dart';

// Define the colors for light mode


class AppColor {
  // Define the colors for light mode
  static const Color primaryColorLight = Colors.blue;
  static const Color accentColorLight = Colors.green;

  // Define the colors for dark mode
  static const Color primaryColorDark = Colors.deepPurple;
  static const Color accentColorDark = Colors.orange;
  static const Color scaffold = Color(0xFF101334);
  static const Color themeColor = Color(0xFFD3FB8F);
  static const Color container = Color(0xFF2A2C58);
}

// Define the light theme
final ThemeData lightTheme = ThemeData(
  primaryColor: AppColor.primaryColorLight,
  hintColor: AppColor.accentColorLight,
  brightness: Brightness.light,
);

// Define the dark theme
final ThemeData darkTheme = ThemeData(
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: AppColor.themeColor
  ),
  scaffoldBackgroundColor: AppColor.scaffold,
  textTheme: const TextTheme(


  ),
  primaryColor: AppColor.primaryColorDark,
  hintColor: AppColor.accentColorDark,
  brightness: Brightness.dark,
);

// Main function to switch between light and dark theme
ThemeData getTheme(BuildContext context) {
  final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;
  return brightnessValue == Brightness.light ? lightTheme : darkTheme;
}
Color getcontainercolor(BuildContext context) {
  Brightness currentBrightness = MediaQuery.of(context).platformBrightness;

  if (currentBrightness == Brightness.light) {
    return AppColor.themeColor; // Set light theme container color
  } else {
    return AppColor.themeColor; // Set dark theme container color
  }
}