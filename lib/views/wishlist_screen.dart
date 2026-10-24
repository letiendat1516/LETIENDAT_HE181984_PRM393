import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/photo.dart';
import '../viewmodels/wishlist_viewmodel.dart';
import '../widgets/photo_card.dart';

/// Screen 2 — WishListPhoto: hiển thị các Photo lưu trong SQLite.
class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlistAsync = ref.watch(wishlistViewModelProvider);

    return RefreshIndicator(
      onRefresh: () =>
          ref.read(wishlistViewModelProvider.notifier).refresh(),
      child: wishlistAsync.when(
        data: (photos) {
          if (photos.isEmpty) {
            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                const SizedBox(height: 120),
                Icon(Icons.favorite_border,
                    size: 72, color: Theme.of(context).hintColor),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    'Chưa có Photo yêu thích nào.\nQuay lại tab Photos và nhấn ❤️',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).hintColor),
                  ),
                ),
              ],
            );
          }
          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: photos.length,
            itemBuilder: (context, index) {
              final Photo photo = photos[index];
              return PhotoCard(
                photo: photo,
                isFavorite: true,
                onToggleFavorite: () =>
                    _confirmRemove(context, ref, photo),
                trailingAction: IconButton(
                  tooltip: 'Xóa khỏi Wishlist',
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => _confirmRemove(context, ref, photo),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Lỗi: $err')),
      ),
    );
  }

  Future<void> _confirmRemove(
    BuildContext context,
    WidgetRef ref,
    Photo photo,
  ) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Bỏ quan tâm?'),
        content: Text(
          'Xóa "${photo.title}" khỏi Wishlist?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Hủy'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
    if (ok != true) return;
    await ref.read(wishlistViewModelProvider.notifier).remove(photo.id);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Text('Đã xóa "${photo.title}" khỏi Wishlist'),
      ),
    );
  }
}
