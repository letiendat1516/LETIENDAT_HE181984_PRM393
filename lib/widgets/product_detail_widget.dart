import 'package:flutter/material.dart';

import 'product_widget.dart';

/// Layer 2: chi tiết sản phẩm đang chọn.
class ProductDetailWidget extends StatelessWidget {
  final Product? product;
  final ValueChanged<Product>? onAddToCart;

  const ProductDetailWidget({super.key, this.product, this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    final Product? p = product;

    // Chưa chọn sản phẩm nào thì nhắc người dùng quay lại tab Home.
    if (p == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Chọn một sản phẩm ở tab Home để xem chi tiết.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ảnh sản phẩm lớn.
          Center(child: ProductWidget(product: p, width: 140)),
          const SizedBox(height: 20),

          // Tên sản phẩm.
          Text(
            p.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // Đánh giá sao.
          _RatingRow(rating: p.rating, reviews: p.reviews),
          const SizedBox(height: 12),

          // Giá + nhãn giảm giá.
          Row(
            children: [
              PriceRow(product: p, fontSize: 24),
              const SizedBox(width: 12),
            ],
          ),
          const SizedBox(height: 16),

          // Mô tả.
          Text(
            p.description,
            style: TextStyle(
              fontSize: 15,
              height: 1.5,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 24),

          // Nút thêm vào giỏ.
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              onPressed: () => onAddToCart?.call(p),
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
              label: const Text(
                'Add to Cart',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E88E5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Dãy 5 ngôi sao + điểm đánh giá + số lượt đánh giá.
class _RatingRow extends StatelessWidget {
  final double rating;
  final int reviews;

  const _RatingRow({required this.rating, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(5, (index) {
          final double diff = rating - index;
          final IconData icon = diff >= 1
              ? Icons.star
              : (diff >= 0.5 ? Icons.star_half : Icons.star_border);
          return Icon(icon, size: 22, color: const Color(0xFFFFA000));
        }),
        const SizedBox(width: 8),
        Text(
          '(${rating.toStringAsFixed(1)}) · $reviews reviews',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
        ),
      ],
    );
  }
}
