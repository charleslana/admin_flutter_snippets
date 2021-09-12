import 'package:admin_flutter_snippets/src/models/news.dart';
import 'package:admin_flutter_snippets/src/providers/news_provider.dart';
import 'package:admin_flutter_snippets/src/routes/routes.dart';
import 'package:admin_flutter_snippets/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({
    required this.news,
    Key? key,
  }) : super(key: key);

  final News news;

  void _deleteNews(BuildContext context, News news) {
    Provider.of<NewsProvider>(context, listen: false).removeNews(news);

    Utils.showSnackBar(
        context, AppLocalizations.of(context)!.snackBarDeletedNews);
  }

  void _editNews(BuildContext context, News news) =>
      Navigator.of(context).pushNamed(
        Routes.editNews,
        arguments: news,
      );

  @override
  Widget build(BuildContext context) {
    final DateFormat _dateFormat =
        DateFormat(AppLocalizations.of(context)!.dateFormat);
    final String formattedDate = _dateFormat.format(news.createdTime!);

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Slidable(
        actionPane: const SlidableDrawerActionPane(),
        key: Key(news.id!),
        actions: [
          IconSlideAction(
            color: Colors.green,
            onTap: () => _editNews(context, news),
            caption: AppLocalizations.of(context)!.newsEdit,
            icon: Icons.edit,
          )
        ],
        secondaryActions: [
          IconSlideAction(
            color: Colors.red,
            caption: AppLocalizations.of(context)!.newsDelete,
            onTap: () => _deleteNews(context, news),
            icon: Icons.delete,
          )
        ],
        child: GestureDetector(
          onTap: () => _editNews(context, news),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Checkbox(
                  value: news.isDisabled,
                  onChanged: (_) {
                    final bool? isDisabled =
                        Provider.of<NewsProvider>(context, listen: false)
                            .toggleNewsStatus(news);

                    Utils.showSnackBar(
                      context,
                      isDisabled!
                          ? AppLocalizations.of(context)!.snackBarNewsDisabled
                          : AppLocalizations.of(context)!.snackBarNewsEnabled,
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
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: ReadMoreText(
                          news.description!,
                          trimLines: 5,
                          delimiter: '',
                          colorClickableText: Colors.indigo,
                          trimMode: TrimMode.Line,
                          trimCollapsedText:
                              '...${AppLocalizations.of(context)!.showMore}',
                          trimExpandedText:
                              ' ${AppLocalizations.of(context)!.showLess}',
                          moreStyle: const TextStyle(
                            fontSize: 20,
                            height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    fontSize: 20,
                                    height: 1.5,
                                  ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        child: Text(
                          formattedDate,
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
        ),
      ),
    );
  }
}
