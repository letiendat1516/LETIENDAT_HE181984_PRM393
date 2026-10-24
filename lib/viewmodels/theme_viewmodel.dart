import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'providers.dart';

part 'theme_viewmodel.g.dart';

/// ViewModel quản lý ThemeMode, lưu bằng SharedPreferences.
@Riverpod(keepAlive: true)
class ThemeViewModel extends _$ThemeViewModel {
  @override
  Future<ThemeMode> build() async {
    final prefs = ref.watch(preferencesServiceProvider);
    return prefs.loadThemeMode();
  }

  Future<void> setMode(ThemeMode mode) async {
    final prefs = ref.read(preferencesServiceProvider);
    state = AsyncData(mode);
    await prefs.saveThemeMode(mode);
  }

  Future<void> toggle() async {
    final current = state.valueOrNull ?? ThemeMode.system;
    final next = switch (current) {
      ThemeMode.system => ThemeMode.light,
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.system,
    };
    await setMode(next);
  }
}
