import 'package:flutter/material.dart';

class CustomThemeData {
  static ThemeData darkData() {
    return ThemeData(
      fontFamily: 'cairo',
      scaffoldBackgroundColor: Color(0xff0D0D0D),
      brightness: Brightness.dark,
      useMaterial3: true,
      dialogBackgroundColor: Color.fromARGB(255, 46, 46, 46),
      textTheme: TextTheme(
        bodySmall: TextStyle(color: Colors.white),
        bodyLarge: TextStyle(color: Colors.grey[400]),
        bodyMedium: TextStyle(color: Color(0xff1E1E1E)),
        titleLarge: TextStyle(color: Colors.black),
      ),
    );
  }

  // =========================================================================

  static ThemeData lightData() {
    return ThemeData(
      fontFamily: 'cairo',
      scaffoldBackgroundColor: Color(0xffFFFFFF),
      useMaterial3: true,
      brightness: Brightness.light,
      dialogBackgroundColor: Color.fromARGB(255, 232, 231, 231),
      textTheme: TextTheme(
        bodySmall: TextStyle(color: Colors.black),
        bodyLarge: TextStyle(color: Colors.grey[700]),
        bodyMedium: TextStyle(color: Color.fromARGB(255, 245, 249, 247)),
        titleLarge: TextStyle(color: Colors.white),

      ),
    );
  }
}
