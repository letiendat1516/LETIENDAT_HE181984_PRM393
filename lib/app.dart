import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'viewmodels/theme_viewmodel.dart';
import 'views/main_scaffold.dart';

/// Root widget: lấy ThemeMode từ ThemeViewModel (SharedPreferences).
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(themeViewModelProvider);
    final themeMode = themeAsync.valueOrNull ?? ThemeMode.system;

    const seed = Color(0xFF1E88E5);

    return MaterialApp(
      title: 'Lab 5 - Photo Wishlist',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.dark,
        ),
      ),
      home: const MainScaffold(),
    );
  }
}
