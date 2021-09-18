import 'package:flutter/material.dart';

CustomTheme currentTheme = new CustomTheme();

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = false;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
        primaryColor: Colors.lightBlue,
        scaffoldBackgroundColor: Colors.cyan[800],
        backgroundColor: Colors.white,
        textTheme: TextTheme(
          headline1: TextStyle(color: Colors.white),
        ));
  }

  static ThemeData get darkTheme {
    return ThemeData(
        primaryColor: Colors.black,
        backgroundColor: Colors.grey[800],
        scaffoldBackgroundColor: Colors.grey[900],
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
          headline1: TextStyle(color: Colors.white),
          headline2: TextStyle(color: Colors.white),
        ));
  }
}
