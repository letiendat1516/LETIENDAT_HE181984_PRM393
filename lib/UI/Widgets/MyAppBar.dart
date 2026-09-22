import 'package:flutter/material.dart';
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool darkMode;
  final VoidCallback onToggleDarkMode;

  MyAppBar({required this.darkMode, required this.onToggleDarkMode});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Không set leading thủ công để Scaffold tự hiển thị nút mở Drawer
      centerTitle: true,
      title: const Text('My Flutter App'),
      actions: [
        IconButton(
          onPressed: onToggleDarkMode,
          icon: Icon(darkMode ? Icons.dark_mode : Icons.light_mode),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}