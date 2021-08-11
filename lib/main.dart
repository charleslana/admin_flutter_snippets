import 'package:admin_flutter_snippets/page/home_page.dart';
import 'package:admin_flutter_snippets/provider/news_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String _title = 'Admin News FS';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => NewsProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: _title,
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            scaffoldBackgroundColor: Color(0xFFf6f5ee),
          ),
          home: HomePage(title: _title),
        ),
      );
}
