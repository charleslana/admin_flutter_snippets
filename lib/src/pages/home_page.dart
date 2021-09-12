import 'package:admin_flutter_snippets/src/api/firebase_api.dart';
import 'package:admin_flutter_snippets/src/models/news.dart';
import 'package:admin_flutter_snippets/src/providers/news_provider.dart';
import 'package:admin_flutter_snippets/src/widgets/add_news_dialog_widget.dart';
import 'package:admin_flutter_snippets/src/widgets/app_bar_widget.dart';
import 'package:admin_flutter_snippets/src/widgets/disabled_news_list_widget.dart';
import 'package:admin_flutter_snippets/src/widgets/news_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
    final List<Widget> tabs = [
      const NewsListWidget(),
      const DisabledNewsListWidget(),
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(
          title: AppLocalizations.of(context)!.appBarHome,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() {
            _selectedIndex = index;
          }),
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.fact_check_outlined),
              label: AppLocalizations.of(context)!.pageHomeActive,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.done, size: 28),
              label: AppLocalizations.of(context)!.pageHomeDisabled,
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
                  return Center(
                    child: Text(
                      AppLocalizations.of(context)!.pageHomeNewsError,
                      style: const TextStyle(
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
          onPressed: () => showDialog<dynamic>(
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
