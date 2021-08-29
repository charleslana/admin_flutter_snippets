import 'package:admin_flutter_snippets/src/l10n/l10n.dart';
import 'package:admin_flutter_snippets/src/pages/home_page.dart';
import 'package:admin_flutter_snippets/src/pages/settings_page.dart';
import 'package:admin_flutter_snippets/src/providers/locale_provider.dart';
import 'package:admin_flutter_snippets/src/providers/news_provider.dart';
import 'package:admin_flutter_snippets/src/providers/theme_provider.dart';
import 'package:admin_flutter_snippets/src/routes/routes.dart';
import 'package:admin_flutter_snippets/src/widgets/route_transition_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  const MyApp({this.sharedPreferences, Key? key}) : super(key: key);

  final SharedPreferences? sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(sharedPreferences),
        ),
        ChangeNotifierProvider(
          create: (_) => LocaleProvider(sharedPreferences),
        ),
        ChangeNotifierProvider(
          create: (_) => NewsProvider(),
        ),
      ],
      child: const MyAppMaterial(),
    );
  }
}

class MyAppMaterial extends StatelessWidget {
  const MyAppMaterial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String title = 'Admin News FS';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      themeMode: Provider.of<ThemeProvider>(context).themeMode,
      theme: lighTheme,
      darkTheme: darkTheme,
      locale: Provider.of<LocaleProvider>(context).locale,
      supportedLocales: L10n.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      initialRoute: Routes.home,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case Routes.home:
            return RouteTransitionWidget(
              widget: const HomePage(title: title),
              settings: settings,
            );
          case Routes.settings:
            return RouteTransitionWidget(
              widget: const SettingsPage(),
              settings: settings,
            );
          default:
            return RouteTransitionWidget(
              widget: const HomePage(title: title),
              settings: settings,
            );
        }
      },
    );
  }
}
