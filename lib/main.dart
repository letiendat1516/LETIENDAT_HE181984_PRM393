import 'package:flutter/material.dart';
import 'package:labflutter/UI/Screens/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool darkMode = false;

  void toggleDarkMode() {
    setState(() {
      darkMode = !darkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      home: HomePage(darkMode: darkMode, onToggleDarkMode: toggleDarkMode),
    );
  }
}

