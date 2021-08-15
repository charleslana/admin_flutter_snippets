import 'package:admin_flutter_snippets/src/model/news.dart';
import 'package:admin_flutter_snippets/src/provider/news_provider.dart';
import 'package:admin_flutter_snippets/src/widget/news_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditNewsPage extends StatefulWidget {
  const EditNewsPage({required this.news, Key? key}) : super(key: key);

  final News news;

  @override
  _EditNewsPageState createState() => _EditNewsPageState();
}

class _EditNewsPageState extends State<EditNewsPage> {
  final _key = GlobalKey<FormState>();

  late String _title;
  late String _description;

  void _saveNews() {
    final isValid = _key.currentState!.validate();

    if (!isValid) {
      return;
    }
    Provider.of<NewsProvider>(context, listen: false)
        .updateNews(widget.news, _title, _description);

    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();

    _title = widget.news.title;
    _description = widget.news.description;
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Edit News'),
            actions: [
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  Provider.of<NewsProvider>(context, listen: false)
                      .removeNews(widget.news);

                  Navigator.of(context).pop();
                },
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _key,
              child: NewsFormWidget(
                title: _title,
                description: _description,
                onChangedTitle: (title) => setState(() => _title = title),
                onChangedDescription: (description) =>
                    setState(() => _description = description),
                onSavedNews: _saveNews,
              ),
            ),
          ),
        ),
      );
}
