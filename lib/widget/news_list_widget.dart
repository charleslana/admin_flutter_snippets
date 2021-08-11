import 'package:admin_flutter_snippets/provider/news_provider.dart';
import 'package:admin_flutter_snippets/widget/news_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsListWidget extends StatelessWidget {
  const NewsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewsProvider>(context);
    final news = provider.news;

    return news.isEmpty
        ? Center(
            child: Text(
              'No News.',
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16),
            separatorBuilder: (context, index) => Container(height: 8),
            itemCount: news.length,
            itemBuilder: (context, index) {
              final newsWidget = news[index];

              return NewsWidget(news: newsWidget);
            },
          );
  }
}
