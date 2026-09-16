import 'package:flutter/material.dart';
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Icon(Icons.menu),
      centerTitle: true,
      title: const Text('My Flutter App'),
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}