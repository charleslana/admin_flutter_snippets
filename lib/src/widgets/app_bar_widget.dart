import 'package:admin_flutter_snippets/src/routes/routes.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    required this.title,
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final String? currentRoute = ModalRoute.of(context)!.settings.name;

    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          onPressed: () {
            if (currentRoute != Routes.settings) {
              Navigator.of(context).pushNamed(Routes.settings);
            }
          },
          icon: const Icon(
            Icons.settings,
          ),
        )
      ],
    );
  }
}
