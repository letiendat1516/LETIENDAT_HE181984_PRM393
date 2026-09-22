import 'package:flutter/material.dart';
import 'package:labflutter/UI/Widgets/MyAppBar.dart';
import 'package:labflutter/UI/Widgets/BodyWidget.dart';
import 'package:labflutter/UI/Screens/core_widgets_demo.dart';
import 'package:labflutter/UI/Screens/input_controls_demo.dart';

class HomePage extends StatelessWidget {
  final Widget? child;
  final bool darkMode;
  final VoidCallback onToggleDarkMode;

  HomePage({this.child, required this.darkMode, required this.onToggleDarkMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(darkMode: darkMode, onToggleDarkMode: onToggleDarkMode),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Text(
                'Lab 4 - Flutter UI',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Trang chủ (Sản phẩm)'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.widgets),
              title: const Text('Bài 1: Core Widgets Demo'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CoreWidgetsDemo()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.tune),
              title: const Text('Bài 2: Input Controls Demo'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const InputControlsDemo()),
                );
              },
            ),
          ],
        ),
      ),
      body: child ?? Bodywidget(),
    );
  }
}