import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider(SharedPreferences? sharedPreferences) {
    final bool? key = sharedPreferences!.getBool(_key);

    if (key == null) {
      isDefaultTheme = true;

      if (brightness == Brightness.dark) {
        themeMode = ThemeMode.dark;
        isDarkMode = true;
      } else {
        themeMode = ThemeMode.light;
        isDarkMode = false;
      }
    } else {
      isDefaultTheme = false;

      if (key) {
        themeMode = ThemeMode.dark;
        isDarkMode = true;
      } else {
        themeMode = ThemeMode.light;
        isDarkMode = false;
      }
    }
  }

  final Brightness brightness =
      MediaQueryData.fromWindow(WidgetsBinding.instance!.window)
          .platformBrightness;
  final String _key = 'sharedDarkMode';
  late ThemeMode themeMode;
  late bool isDefaultTheme;
  late bool isDarkMode;

  Future<void> remove() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.remove(_key);

    isDefaultTheme = true;

    if (brightness == Brightness.dark) {
      themeMode = ThemeMode.dark;
      isDarkMode = true;
    } else {
      themeMode = ThemeMode.light;
      isDarkMode = false;
    }

    notifyListeners();
  }

  Future<void> toggle({required bool isOn}) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    if (isOn) {
      await preferences.setBool(_key, true);

      themeMode = ThemeMode.dark;
      isDarkMode = true;
    } else {
      await preferences.setBool(_key, false);

      themeMode = ThemeMode.light;
      isDarkMode = false;
    }

    isDefaultTheme = false;

    notifyListeners();
  }
}

final lighTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Colors.orangeAccent,
  colorScheme: const ColorScheme.light().copyWith(
    primary: Colors.orangeAccent,
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.orangeAccent;
        }
        return Colors.white.withAlpha(700);
      },
    ),
    trackColor: MaterialStateProperty.all(Colors.grey.withAlpha(700)),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.orangeAccent;
        }
        return Colors.grey;
      },
    ),
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.orangeAccent;
        }
        return Colors.grey;
      },
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Colors.orangeAccent,
  ),
);

final darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.grey.shade900,
  primaryColor: Colors.orangeAccent,
  colorScheme: const ColorScheme.dark().copyWith(
    primary: Colors.orangeAccent,
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.orangeAccent;
        }
        return Colors.white.withAlpha(700);
      },
    ),
    trackColor: MaterialStateProperty.all(Colors.grey.withAlpha(700)),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.orangeAccent;
        }
        return Colors.grey;
      },
    ),
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.orangeAccent;
        }
        return Colors.grey;
      },
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Colors.orangeAccent,
  ),
);
