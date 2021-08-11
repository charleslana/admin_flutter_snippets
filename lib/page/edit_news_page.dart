import 'package:admin_flutter_snippets/model/news.dart';
import 'package:admin_flutter_snippets/provider/news_provider.dart';
import 'package:admin_flutter_snippets/widget/news_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditNewsPage extends StatefulWidget {
  final News news;

  const EditNewsPage({required this.news, Key? key}) : super(key: key);

  @override
  _EditNewsPageState createState() => _EditNewsPageState();
}

class _EditNewsPageState extends State<EditNewsPage> {
  final _formKey = GlobalKey<FormState>();

  late String _title;
  late String _description;

  void _saveNews() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }
    final provider = Provider.of<NewsProvider>(context, listen: false);

    provider.updateNews(widget.news, _title, _description);

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
            title: Text('Edit News'),
            actions: [
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  final provider =
                      Provider.of<NewsProvider>(context, listen: false);
                  provider.removeNews(widget.news);

                  Navigator.of(context).pop();
                },
              )
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: NewsFormWidget(
                title: _title,
                description: _description,
                onChangedTitle: (title) => setState(() => this._title = title),
                onChangedDescription: (description) =>
                    setState(() => this._description = description),
                onSavedNews: _saveNews,
              ),
            ),
          ),
        ),
      );
}
