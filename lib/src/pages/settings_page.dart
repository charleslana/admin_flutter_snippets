import 'package:admin_flutter_snippets/src/l10n/l10n.dart';
import 'package:admin_flutter_snippets/src/providers/locale_provider.dart';
import 'package:admin_flutter_snippets/src/providers/theme_provider.dart';
import 'package:admin_flutter_snippets/src/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late bool _isDefaultTheme;
  late bool _isDarkMode;
  late bool _isDefaultLanguage;
  late int _language;

  void _selectDefaultTheme() {
    final ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false)..remove();

    themeProvider.brightness == Brightness.dark
        ? _isDarkMode = true
        : _isDarkMode = false;

    setState(() {
      _isDefaultTheme = true;
    });
  }

  void _toggleDarkMode(bool value) {
    Provider.of<ThemeProvider>(context, listen: false).toggle(isOn: value);

    setState(() {
      _isDefaultTheme = false;
      _isDarkMode = value;
    });
  }

  void _selectDefaultLanguage() {
    final LocaleProvider localeProvider = Provider.of(context, listen: false)
      ..remove();

    setState(() {
      _isDefaultLanguage = true;
      _language = L10n().getLanguage(localeProvider.languageCode);
    });
  }

  void _changeLanguage(Object? value, Locale locale) {
    Provider.of<LocaleProvider>(context, listen: false).set(locale);

    setState(() {
      _isDefaultLanguage = false;
      _language = int.parse(value.toString());
    });
  }

  @override
  void initState() {
    final ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    final LocaleProvider localeProvider =
        Provider.of<LocaleProvider>(context, listen: false);

    setState(() {
      _isDefaultTheme = themeProvider.isDefaultTheme;
      _isDarkMode = themeProvider.isDarkMode;
      _isDefaultLanguage = localeProvider.isDefaultLanguage;
      _language = L10n().getLanguage(localeProvider.locale.languageCode);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(
          title: AppLocalizations.of(context)!.appBarSettings,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                AppLocalizations.of(context)!.pageSettingsTheme,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(
                height: 30,
              ),
              CheckboxListTile(
                title: Text(
                    AppLocalizations.of(context)!.pageSettingsDefaultTheme),
                value: _isDefaultTheme,
                onChanged: (_) => _selectDefaultTheme(),
              ),
              SwitchListTile(
                title: Text(AppLocalizations.of(context)!.pageSettingsDarkMode),
                value: _isDarkMode,
                onChanged: _toggleDarkMode,
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                AppLocalizations.of(context)!.pageSettingsLanguage,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(
                height: 30,
              ),
              CheckboxListTile(
                title: Text(
                    AppLocalizations.of(context)!.pageSettingsDefaultLanguage),
                value: _isDefaultLanguage,
                onChanged: (_) => _selectDefaultLanguage(),
              ),
              RadioListTile(
                value: 1,
                groupValue: _language,
                onChanged: (value) =>
                    _changeLanguage(value, L10n.supportedLocales[0]),
                title: Text(
                    AppLocalizations.of(context)!.pageSettingsLanguageEnglish),
                controlAffinity: ListTileControlAffinity.trailing,
              ),
              RadioListTile(
                value: 2,
                groupValue: _language,
                onChanged: (value) =>
                    _changeLanguage(value, L10n.supportedLocales[1]),
                title: Text(
                    AppLocalizations.of(context)!.pageSettingsLanguageSpanish),
                controlAffinity: ListTileControlAffinity.trailing,
              ),
              RadioListTile(
                value: 3,
                groupValue: _language,
                onChanged: (value) =>
                    _changeLanguage(value, L10n.supportedLocales[2]),
                title: Text(AppLocalizations.of(context)!
                    .pageSettingsLanguagePortuguese),
                controlAffinity: ListTileControlAffinity.trailing,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
