import 'package:admin_flutter_snippets/src/model/news.dart';
import 'package:admin_flutter_snippets/src/provider/news_provider.dart';
import 'package:admin_flutter_snippets/src/widget/news_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNewsDialogWidget extends StatefulWidget {
  const AddNewsDialogWidget({Key? key}) : super(key: key);

  @override
  _AddNewsDialogWidgetState createState() => _AddNewsDialogWidgetState();
}

class _AddNewsDialogWidgetState extends State<AddNewsDialogWidget> {
  final _key = GlobalKey<FormState>();
  String title = '';
  String description = '';

  void addNews() {
    final isValid = _key.currentState!.validate();

    if (!isValid) {
      return;
    }

    final news = News(
      id: DateTime.now().toString(),
      title: title,
      description: description,
      createdTime: DateTime.now(),
    );

    Provider.of<NewsProvider>(context, listen: false).addNews(news);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Form(
          key: _key,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add News',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 8),
              NewsFormWidget(
                onChangedTitle: (title) => setState(() => this.title = title),
                onChangedDescription: (description) =>
                    setState(() => this.description = description),
                onSavedNews: addNews,
              ),
            ],
          ),
        ),
      );
}
