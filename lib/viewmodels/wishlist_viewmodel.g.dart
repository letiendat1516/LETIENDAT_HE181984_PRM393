// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$wishlistViewModelHash() => r'46e3c9d0bb102214e21ed72354f96db801a51098';

/// ViewModel quản lý danh sách photo đã "quan tâm" (wishlist) trong SQLite.
///
/// Copied from [WishlistViewModel].
@ProviderFor(WishlistViewModel)
final wishlistViewModelProvider =
    AsyncNotifierProvider<WishlistViewModel, List<Photo>>.internal(
      WishlistViewModel.new,
      name: r'wishlistViewModelProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$wishlistViewModelHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$WishlistViewModel = AsyncNotifier<List<Photo>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
