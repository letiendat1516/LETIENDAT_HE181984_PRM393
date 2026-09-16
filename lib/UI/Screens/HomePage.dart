import 'package:flutter/material.dart';
import 'package:example/UI/Widgets/MyAppBar.dart';
import 'package:example/UI/Widgets/BodyWidget.dart';
class HomePage extends StatelessWidget {
  final Widget? child;

  HomePage({this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        centerTitle: true,
        title: const Text('My Flutter App'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
      ),
      body: child ?? Bodywidget()
    );
  }
}