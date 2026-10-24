import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/photo.dart';
import 'providers.dart';

part 'photo_list_viewmodel.g.dart';

/// ViewModel cho màn hình danh sách Photo.
/// Trả về danh sách Photo tải từ API (JSONPlaceholder).
@riverpod
class PhotoListViewModel extends _$PhotoListViewModel {
  @override
  Future<List<Photo>> build() async {
    final repo = ref.watch(photoRepositoryProvider);
    return repo.getPhotos(limit: 100);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(photoRepositoryProvider);
      return repo.getPhotos(limit: 100);
    });
  }
}
