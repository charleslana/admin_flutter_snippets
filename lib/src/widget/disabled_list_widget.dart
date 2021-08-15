import 'package:admin_flutter_snippets/src/provider/news_provider.dart';
import 'package:admin_flutter_snippets/src/widget/news_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisabledListWidget extends StatelessWidget {
  const DisabledListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewsProvider>(context);
    final news = provider.newsDisabled;

    return news.isEmpty
        ? const Center(
            child: Text(
              'No disabled news.',
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            separatorBuilder: (context, index) => Container(height: 8),
            itemCount: news.length,
            itemBuilder: (context, index) {
              final newsWidget = news[index];

              return NewsWidget(news: newsWidget);
            },
          );
  }
}
