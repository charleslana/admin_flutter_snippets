import 'package:admin_flutter_snippets/src/api/firebase_api.dart';
import 'package:admin_flutter_snippets/src/models/news.dart';
import 'package:admin_flutter_snippets/src/providers/news_provider.dart';
import 'package:admin_flutter_snippets/src/widgets/add_news_dialog_widget.dart';
import 'package:admin_flutter_snippets/src/widgets/disabled_list_widget.dart';
import 'package:admin_flutter_snippets/src/widgets/news_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({required this.title, Key? key}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const NewsListWidget(),
      const DisabledListWidget(),
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white.withOpacity(0.7),
          selectedItemColor: Colors.white,
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() {
            _selectedIndex = index;
          }),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.fact_check_outlined),
              label: 'Active',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.done, size: 28),
              label: 'Disabled',
            ),
          ],
        ),
        body: StreamBuilder<List<News>>(
          stream: FirebaseApi.readNews(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return buildText('Something Went Wrong Try later');
                } else {
                  final news = snapshot.data;

                  Provider.of<NewsProvider>(context).setNews(news);

                  return tabs[_selectedIndex];
                }
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.black,
          onPressed: () => showDialog(
            context: context,
            builder: (context) => const AddNewsDialogWidget(),
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
