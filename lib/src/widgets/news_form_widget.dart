import 'package:flutter/material.dart';

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTitle(),
            const SizedBox(height: 8),
            buildDescription(),
            const SizedBox(height: 16),
            buildButton(),
          ],
        ),
      );

  Widget buildTitle() => TextFormField(
        initialValue: title,
        onChanged: onChangedTitle,
        validator: (title) {
          if (title!.trim().isEmpty) {
            return 'The title cannot be empty';
          }
          return null;
        },
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Title',
        ),
      );

  Widget buildDescription() => TextFormField(
        maxLines: 5,
        initialValue: description,
        onChanged: onChangedDescription,
        validator: (description) {
          if (description!.trim().isEmpty) {
            return 'The description cannot be empty';
          }
          return null;
        },
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Description',
        ),
      );

  Widget buildButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onSavedNews,
          child: const Text('Save'),
        ),
      );
}
