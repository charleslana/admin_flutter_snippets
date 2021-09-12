import 'package:admin_flutter_snippets/src/models/news.dart';
import 'package:admin_flutter_snippets/src/providers/news_provider.dart';
import 'package:admin_flutter_snippets/src/widgets/news_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditNewsPage extends StatefulWidget {
  const EditNewsPage({Key? key}) : super(key: key);

  @override
  _EditNewsPageState createState() => _EditNewsPageState();
}

class _EditNewsPageState extends State<EditNewsPage> {
  late final News _news = ModalRoute.of(context)!.settings.arguments as News;
  final _key = GlobalKey<FormState>();

  String _title = '';
  String _description = '';
  DateTime _createdTime = DateTime.now();

  void _saveNews() {
    final isValid = _key.currentState!.validate();

    if (!isValid) {
      return;
    }

    Provider.of<NewsProvider>(context, listen: false)
        .updateNews(_news, _title, _description);

    Navigator.of(context).pop();
  }

  Future<void> init() async {
    await Future<void>.delayed(Duration.zero).then((_) {
      setState(() {
        _title = _news.title!;
        _description = _news.description!;
        _createdTime = _news.createdTime!;
      });
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat _dateFormat =
        DateFormat(AppLocalizations.of(context)!.dateFormat);
    final String formattedDate = _dateFormat.format(_createdTime);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(formattedDate),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                Provider.of<NewsProvider>(context, listen: false)
                    .removeNews(_news);

                Navigator.of(context).pop();
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _key,
            child: _createdTime == DateTime.now()
                ? const Center(child: CircularProgressIndicator())
                : NewsFormWidget(
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
}
