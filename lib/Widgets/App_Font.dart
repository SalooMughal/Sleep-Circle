import 'package:flutter/material.dart';

class AppFonts {
  static const String fontFamily = 'Poppins';
  static const String fontFamily_Bold = 'Poppins_Bold';

  static const TextStyle regular = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle bold = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle italic = TextStyle(
    fontFamily: fontFamily,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle boldItalic = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
  );

// Add more styles as needed
}
