import 'package:admin_flutter_snippets/src/api/firebase_api.dart';
import 'package:admin_flutter_snippets/src/models/news.dart';
import 'package:admin_flutter_snippets/src/providers/news_provider.dart';
import 'package:admin_flutter_snippets/src/widgets/add_news_dialog_widget.dart';
import 'package:admin_flutter_snippets/src/widgets/app_bar_widget.dart';
import 'package:admin_flutter_snippets/src/widgets/disabled_list_widget.dart';
import 'package:admin_flutter_snippets/src/widgets/news_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const NewsListWidget(),
      const DisabledListWidget(),
    ];

    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget(
          title: 'News',
        ),
        bottomNavigationBar: BottomNavigationBar(
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
                  return const Center(
                    child: Text(
                      'Something Went Wrong Try later',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  );
                } else {
                  Provider.of<NewsProvider>(context).setNews(snapshot.data);

                  return tabs[_selectedIndex];
                }
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showDialog(
            context: context,
            builder: (context) => const AddNewsDialogWidget(),
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
