import 'package:admin_flutter_snippets/src/models/news.dart';
import 'package:admin_flutter_snippets/src/providers/news_provider.dart';
import 'package:admin_flutter_snippets/src/widgets/news_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class AddNewsDialogWidget extends StatefulWidget {
  const AddNewsDialogWidget({Key? key}) : super(key: key);

  @override
  _AddNewsDialogWidgetState createState() => _AddNewsDialogWidgetState();
}

class _AddNewsDialogWidgetState extends State<AddNewsDialogWidget> {
  final _key = GlobalKey<FormState>();
  String _title = '';
  String _description = '';

  void addNews() {
    final isValid = _key.currentState!.validate();

    if (!isValid) {
      return;
    }

    final news = News(
      id: DateTime.now().toString(),
      title: _title,
      description: _description,
      createdTime: DateTime.now(),
    );

    Provider.of<NewsProvider>(context, listen: false).addNews(news);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _key,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.dialogAddNews,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 8),
            Flexible(
              child: NewsFormWidget(
                onChangedTitle: (title) => setState(() => _title = title),
                onChangedDescription: (description) =>
                    setState(() => _description = description),
                onSavedNews: addNews,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
