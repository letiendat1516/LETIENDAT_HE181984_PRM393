import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/photo.dart';
import '../viewmodels/photo_list_viewmodel.dart';
import '../viewmodels/wishlist_viewmodel.dart';
import '../widgets/photo_card.dart';

/// Screen 1 — danh sách Photo từ API JSONPlaceholder.
class PhotoListScreen extends ConsumerWidget {
  const PhotoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photosAsync = ref.watch(photoListViewModelProvider);
    final wishlistAsync = ref.watch(wishlistViewModelProvider);

    return RefreshIndicator(
      onRefresh: () =>
          ref.read(photoListViewModelProvider.notifier).refresh(),
      child: photosAsync.when(
        data: (photos) {
          if (photos.isEmpty) {
            return const _EmptyState(message: 'Không có photo nào.');
          }
          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: photos.length,
            itemBuilder: (context, index) {
              final Photo photo = photos[index];
              final bool isFav = wishlistAsync.maybeWhen(
                data: (list) => list.any((p) => p.id == photo.id),
                orElse: () => false,
              );
              return PhotoCard(
                photo: photo,
                isFavorite: isFav,
                onToggleFavorite: () async {
                  final nowFav = await ref
                      .read(wishlistViewModelProvider.notifier)
                      .toggle(photo);
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 1),
                      content: Text(
                        nowFav
                            ? 'Đã thêm "${photo.title}" vào Wishlist'
                            : 'Đã bỏ "${photo.title}" khỏi Wishlist',
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => _ErrorState(
          message: '$err',
          onRetry: () =>
              ref.read(photoListViewModelProvider.notifier).refresh(),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        const SizedBox(height: 120),
        Icon(Icons.photo_library_outlined,
            size: 72, color: Theme.of(context).hintColor),
        const SizedBox(height: 12),
        Center(
          child: Text(message,
              style: TextStyle(color: Theme.of(context).hintColor)),
        ),
      ],
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(24),
      children: [
        const SizedBox(height: 80),
        const Icon(Icons.error_outline, size: 64, color: Colors.red),
        const SizedBox(height: 12),
        Center(
          child: Text(message, textAlign: TextAlign.center),
        ),
        const SizedBox(height: 16),
        Center(
          child: FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Thử lại'),
          ),
        ),
      ],
    );
  }
}
