import 'package:flutter/material.dart';
import 'package:group_project/config/app_theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = AppTheme.lightTheme;

  ThemeData get themeData => _themeData;
  bool get isDarkTheme => _themeData == AppTheme.darkTheme;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (isDarkTheme) {
      _themeData = AppTheme.lightTheme;
    } else {
      _themeData = AppTheme.darkTheme;
    }

    notifyListeners();
  }
}
