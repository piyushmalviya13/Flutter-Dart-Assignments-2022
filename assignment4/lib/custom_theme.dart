import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Poppins',
        buttonTheme: ButtonThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: Colors.blueAccent,
        ));
  }
}
