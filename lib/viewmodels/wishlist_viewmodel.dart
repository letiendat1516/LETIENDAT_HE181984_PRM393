import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/photo.dart';
import 'providers.dart';

part 'wishlist_viewmodel.g.dart';

/// ViewModel quản lý danh sách photo đã "quan tâm" (wishlist) trong SQLite.
@Riverpod(keepAlive: true)
class WishlistViewModel extends _$WishlistViewModel {
  @override
  Future<List<Photo>> build() async {
    final repo = ref.watch(wishlistRepositoryProvider);
    return repo.getAll();
  }

  /// Kiểm tra xem photo [id] có trong wishlist không (dùng để tô icon trái tim).
  bool isFavorite(int id) {
    final current = state.valueOrNull;
    if (current == null) return false;
    return current.any((p) => p.id == id);
  }

  /// Toggle quan tâm / bỏ quan tâm. Trả về trạng thái mới (true = đang quan tâm).
  Future<bool> toggle(Photo photo) async {
    final repo = ref.read(wishlistRepositoryProvider);
    final nowFavorite = !isFavorite(photo.id);
    if (nowFavorite) {
      await repo.insert(photo);
    } else {
      await repo.remove(photo.id);
    }
    state = AsyncData(await repo.getAll());
    return nowFavorite;
  }

  /// Xóa khỏi wishlist (dùng ở màn WishList).
  Future<void> remove(int id) async {
    final repo = ref.read(wishlistRepositoryProvider);
    await repo.remove(id);
    state = AsyncData(await repo.getAll());
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(wishlistRepositoryProvider);
      return repo.getAll();
    });
  }
}
