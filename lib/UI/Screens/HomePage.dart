import 'package:flutter/material.dart';
import 'package:labflutter/UI/Widgets/MyAppBar.dart';
import 'package:labflutter/UI/Widgets/BodyWidget.dart';

class HomePage extends StatelessWidget {
  final Widget? child;
  final bool darkMode;
  final VoidCallback onToggleDarkMode;

  HomePage({this.child, required this.darkMode, required this.onToggleDarkMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(darkMode: darkMode, onToggleDarkMode: onToggleDarkMode),
      body: child ?? Bodywidget(),
    );
  }
}