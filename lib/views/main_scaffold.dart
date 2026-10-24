import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodels/theme_viewmodel.dart';
import 'photo_list_screen.dart';
import 'wishlist_screen.dart';

/// Scaffold chung chứa 2 screen: Photos (API) và WishList (SQLite).
class MainScaffold extends ConsumerStatefulWidget {
  const MainScaffold({super.key});

  @override
  ConsumerState<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends ConsumerState<MainScaffold> {
  int _index = 0;

  static const _titles = ['Photos', 'Wishlist'];

  @override
  Widget build(BuildContext context) {
    final themeAsync = ref.watch(themeViewModelProvider);

    final screens = const [PhotoListScreen(), WishlistScreen()];

    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_index]),
        centerTitle: true,
        actions: [
          themeAsync.when(
            data: (mode) => IconButton(
              tooltip: 'Chế độ: ${_describeMode(mode)}',
              icon: Icon(_iconForMode(mode)),
              onPressed: () => _openThemePicker(context, mode),
            ),
            loading: () => const SizedBox(
              width: 48,
              child: Center(
                child: SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            ),
            error: (_, __) => const Icon(Icons.error_outline),
          ),
        ],
      ),
      body: IndexedStack(index: _index, children: screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (v) => setState(() => _index = v),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.photo_library_outlined),
            selectedIcon: Icon(Icons.photo_library),
            label: 'Photos',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
        ],
      ),
    );
  }

  IconData _iconForMode(ThemeMode mode) => switch (mode) {
        ThemeMode.light => Icons.light_mode,
        ThemeMode.dark => Icons.dark_mode,
        ThemeMode.system => Icons.brightness_auto,
      };

  String _describeMode(ThemeMode mode) => switch (mode) {
        ThemeMode.light => 'Light',
        ThemeMode.dark => 'Dark',
        ThemeMode.system => 'System',
      };

  Future<void> _openThemePicker(
      BuildContext context, ThemeMode current) async {
    final selected = await showDialog<ThemeMode>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('Chọn Theme Mode'),
        children: [
          for (final mode in ThemeMode.values)
            RadioListTile<ThemeMode>(
              value: mode,
              groupValue: current,
              title: Text(_describeMode(mode)),
              secondary: Icon(_iconForMode(mode)),
              onChanged: (v) => Navigator.pop(ctx, v),
            ),
        ],
      ),
    );
    if (selected == null) return;
    await ref.read(themeViewModelProvider.notifier).setMode(selected);
  }
}
