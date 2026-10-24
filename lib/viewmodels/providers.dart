import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repositories/photo_repository.dart';
import '../repositories/wishlist_repository.dart';
import '../services/database_service.dart';
import '../services/photo_api_service.dart';
import '../services/preferences_service.dart';

part 'providers.g.dart';

/// Provider cho các service / repository dùng chung.
@Riverpod(keepAlive: true)
PhotoApiService photoApiService(Ref ref) {
  final service = PhotoApiService();
  ref.onDispose(service.dispose);
  return service;
}

@Riverpod(keepAlive: true)
DatabaseService databaseService(Ref ref) {
  return DatabaseService.instance;
}

@Riverpod(keepAlive: true)
PreferencesService preferencesService(Ref ref) {
  return PreferencesService.instance;
}

@Riverpod(keepAlive: true)
PhotoRepository photoRepository(Ref ref) {
  return PhotoRepository(ref.watch(photoApiServiceProvider));
}

@Riverpod(keepAlive: true)
WishlistRepository wishlistRepository(Ref ref) {
  return WishlistRepository(ref.watch(databaseServiceProvider));
}
