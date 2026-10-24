// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_list_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$photoListViewModelHash() =>
    r'a7649ce4a2e74ff7a22cc47ee09b38eea12ed7ee';

/// ViewModel cho màn hình danh sách Photo.
/// Trả về danh sách Photo tải từ API (JSONPlaceholder).
///
/// Copied from [PhotoListViewModel].
@ProviderFor(PhotoListViewModel)
final photoListViewModelProvider =
    AutoDisposeAsyncNotifierProvider<PhotoListViewModel, List<Photo>>.internal(
      PhotoListViewModel.new,
      name: r'photoListViewModelProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$photoListViewModelHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PhotoListViewModel = AutoDisposeAsyncNotifier<List<Photo>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
