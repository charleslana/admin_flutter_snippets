import 'dart:ui' as ui;

import 'package:admin_flutter_snippets/src/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  LocaleProvider(SharedPreferences? sharedPreferences) {
    final String? sharedLocale = sharedPreferences!.getString(_key);
    final Iterable<Locale> supportedLocales =
        L10n.supportedLocales.where((locale) => locale == Locale(languageCode));

    if (sharedLocale == null) {
      isDefaultLanguage = true;

      supportedLocales.isNotEmpty
          ? locale = Locale(languageCode)
          : locale = const Locale('en');
    } else {
      isDefaultLanguage = false;
      locale = Locale(sharedLocale);
    }
  }

  final String languageCode = ui.window.locale.languageCode;
  final String _key = 'sharedLocale';
  late Locale locale;
  late bool isDefaultLanguage;

  Future<void> remove() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.remove(_key);

    isDefaultLanguage = true;

    final Iterable<Locale> supportedLocales =
        L10n.supportedLocales.where((locale) => locale == Locale(languageCode));

    supportedLocales.isNotEmpty
        ? locale = Locale(languageCode)
        : locale = const Locale('en');

    notifyListeners();
  }

  Future<void> set(Locale value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    await preferences.setString(_key, value.languageCode);

    locale = value;
    isDefaultLanguage = false;

    notifyListeners();
  }
}
