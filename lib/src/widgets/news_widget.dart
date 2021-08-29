import 'package:admin_flutter_snippets/src/models/news.dart';
import 'package:admin_flutter_snippets/src/pages/edit_news_page.dart';
import 'package:admin_flutter_snippets/src/providers/news_provider.dart';
import 'package:admin_flutter_snippets/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({required this.news, Key? key}) : super(key: key);

  final News news;

  Widget buildNews(BuildContext context) {
    return GestureDetector(
      onTap: () => editNews(context, news),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Checkbox(
              activeColor: Theme.of(context).primaryColor,
              checkColor: Colors.white,
              value: news.isDisabled,
              onChanged: (_) {
                final provider =
                    Provider.of<NewsProvider>(context, listen: false);
                final isDisabled = provider.toggleNewsStatus(news);

                Utils.showSnackBar(
                  context,
                  isDisabled! ? 'News disabled' : 'News enabled',
                );
              },
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                      fontSize: 22,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    child: Text(
                      news.description!,
                      style: const TextStyle(
                        fontSize: 20,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void deleteNews(BuildContext context, News news) {
    Provider.of<NewsProvider>(context, listen: false).removeNews(news);

    Utils.showSnackBar(context, 'Deleted the news');
  }

  void editNews(BuildContext context, News news) => Navigator.of(context).push(
        MaterialPageRoute<dynamic>(
          builder: (context) => EditNewsPage(news: news),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Slidable(
        actionPane: const SlidableDrawerActionPane(),
        key: Key(news.id!),
        actions: [
          IconSlideAction(
            color: Colors.green,
            onTap: () => editNews(context, news),
            caption: 'Edit',
            icon: Icons.edit,
          )
        ],
        secondaryActions: [
          IconSlideAction(
            color: Colors.red,
            caption: 'Delete',
            onTap: () => deleteNews(context, news),
            icon: Icons.delete,
          )
        ],
        child: buildNews(context),
      ),
    );
  }
}
