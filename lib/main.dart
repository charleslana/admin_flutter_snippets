import 'package:admin_flutter_snippets/src/l10n/l10n.dart';
import 'package:admin_flutter_snippets/src/pages/edit_news_page.dart';
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
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  runApp(MyApp(
    sharedPreferences: sharedPreferences,
    packageInfo: packageInfo,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    this.sharedPreferences,
    this.packageInfo,
    Key? key,
  }) : super(key: key);

  final SharedPreferences? sharedPreferences;
  final PackageInfo? packageInfo;

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
      child: MyAppMaterial(appName: packageInfo!.appName),
    );
  }
}

class MyAppMaterial extends StatelessWidget {
  const MyAppMaterial({
    required this.appName,
    Key? key,
  }) : super(key: key);

  final String appName;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
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
              widget: const HomePage(),
              settings: settings,
            );
          case Routes.settings:
            return RouteTransitionWidget(
              widget: const SettingsPage(),
              settings: settings,
            );
          case Routes.editNews:
            return RouteTransitionWidget(
              widget: const EditNewsPage(),
              settings: settings,
            );
          default:
            return RouteTransitionWidget(
              widget: const HomePage(),
              settings: settings,
            );
        }
      },
    );
  }
}
