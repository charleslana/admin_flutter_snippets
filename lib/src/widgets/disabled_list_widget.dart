import 'package:admin_flutter_snippets/src/providers/news_provider.dart';
import 'package:admin_flutter_snippets/src/widgets/news_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class DisabledListWidget extends StatelessWidget {
  const DisabledListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final news = Provider.of<NewsProvider>(context).newsDisabled;

    return news.isEmpty
        ? Center(
            child: Text(
              AppLocalizations.of(context)!.noDisabledNews,
              style: const TextStyle(fontSize: 20),
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
