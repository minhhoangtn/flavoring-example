import 'package:flutter/material.dart';

enum CustomTheme { light, dark }

class AppTheme extends ChangeNotifier {
  CustomTheme currentTheme;
  AppTheme(this.currentTheme);

  void changeTheme(CustomTheme nextTheme) {
    currentTheme = nextTheme;
    notifyListeners();
  }

  ThemeData get themeData {
    switch (currentTheme) {
      case CustomTheme.light:
        return ThemeData(
            primarySwatch: Colors.teal,
            inputDecorationTheme: const InputDecorationTheme());
      case CustomTheme.dark:
        return ThemeData(
            primarySwatch: Colors.red,
            inputDecorationTheme: const InputDecorationTheme());
    }
  }
}
