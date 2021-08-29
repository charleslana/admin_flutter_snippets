import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewsFormWidget extends StatelessWidget {
  const NewsFormWidget({
    Key? key,
    this.title,
    this.description,
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onSavedNews,
  }) : super(key: key);

  final String? title;
  final String? description;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final VoidCallback onSavedNews;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTitle(context),
            const SizedBox(height: 8),
            buildDescription(context),
            const SizedBox(height: 16),
            buildButton(context),
          ],
        ),
      );

  Widget buildTitle(BuildContext context) => TextFormField(
        initialValue: title,
        onChanged: onChangedTitle,
        validator: (title) {
          if (title!.trim().isEmpty) {
            return AppLocalizations.of(context)!.formTitleIsEmpty;
          }
          return null;
        },
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          labelText: AppLocalizations.of(context)!.formTitle,
        ),
      );

  Widget buildDescription(BuildContext context) => TextFormField(
        maxLines: 5,
        initialValue: description,
        onChanged: onChangedDescription,
        validator: (description) {
          if (description!.trim().isEmpty) {
            return AppLocalizations.of(context)!.formDescriptionIsEmpty;
          }
          return null;
        },
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          labelText: AppLocalizations.of(context)!.formDescription,
        ),
      );

  Widget buildButton(BuildContext context) => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onSavedNews,
          child: Text(AppLocalizations.of(context)!.formSave),
        ),
      );
}
