import 'package:flutter/material.dart';

/// Model dữ liệu của một sản phẩm.
class Product {
  final String name;
  final double price;
  final double rating;
  final int reviews;
  final String description;

  /// Link ảnh thật của sản phẩm (tải qua mạng).
  final String imageUrl;

  /// Icon + màu dùng để vẽ ảnh dự phòng khi tải ảnh mạng thất bại.
  final IconData icon;
  final List<Color> colors;

  /// Tỉ lệ cao / rộng của khung ảnh (điện thoại cao, laptop ngang).
  final double aspect;

  /// Trạng thái đã lưu / bookmark của sản phẩm.
  final bool isSaved;

  const Product({
    required this.name,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.description,
    required this.imageUrl,
    required this.icon,
    required this.colors,
    this.aspect = 1.2,
    this.isSaved = false,
  });

  /// Phần trăm giảm giá, ví dụ 1099 -> 999 là 9%.

  String get priceText => '\$${price.toStringAsFixed(0)}';
}

/// Danh sách sản phẩm mẫu.
const List<Product> sampleProducts = [
  Product(
    name: 'Flutter Developer',
    price: 999,
    rating: 4.8,
    reviews: 120,
    description:
        'Experience the latest technology with the new iPhone 15. '
        'Stunning design, powerful performance.',
    imageUrl:
        'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/'
        'https://cellphones.com.vn/media/catalog/product/i/p/iphone-15-plus-256gb_3.png',
    icon: Icons.phone_iphone,
    colors: [Color(0xFF1565C0), Color(0xFFD32F2F)],
  ),
  Product(
    name: 'AI Fundamentals',
    price: 899,
    rating: 4.6,
    reviews: 86,
    description:
        'Samsung Galaxy S24 with a brilliant AMOLED display, '
        'all-day battery and a pro-grade camera system.',
    imageUrl:
        'https://cdn2.fptshop.com.vn/unsafe/512x0/filters:format(webp):quality(75)/'
        '2024_1_29_638421471246167545_samsung-galaxy-s24-xam-1.png',
    icon: Icons.smartphone,
    colors: [Color(0xFF0288D1), Color(0xFF1A237E)],
  ),
  Product(
    name: 'Web Development',
    price: 100,
    rating: 4.9,
    reviews: 45,
    description:
        'MacBook Air is thin, light and incredibly fast. '
        'Silent fanless design with up to 18 hours of battery life.',
    imageUrl:
        'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/44/363477/'
        'macbook-air-15-inch-m5-16gb-512gb-1-639082296102887036.jpg',
    icon: Icons.laptop_mac,
    colors: [Color(0xFF7B1FA2), Color(0xFFEC407A)],
    aspect: 0.8,
  ),
  Product(
    name: 'Mobile Development',
    price: 100,
    rating: 4.9,
    reviews: 45,
    description:
    'MacBook Air is thin, light and incredibly fast. '
        'Silent fanless design with up to 18 hours of battery life.',
    imageUrl:
    'https://cdnv2.tgdd.vn/mwg-static/tgdd/Products/Images/44/363477/'
        'macbook-air-15-inch-m5-16gb-512gb-1-639082296102887036.jpg',
    icon: Icons.laptop_mac,
    colors: [Color(0xFF7B1FA2), Color(0xFFEC407A)],
    aspect: 0.8,
  ),
];

class ProductWidget extends StatelessWidget {
  final Product product;

  final double width;

  const ProductWidget({super.key, required this.product, this.width = 64});

  @override
  Widget build(BuildContext context) {
    final double height = width * product.aspect;
    final double radius = width * 0.16;

    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(width * 0.06),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: width * 0.12,
            offset: Offset(0, width * 0.04),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius * 0.7),
        child: Image.network(
          product.imageUrl,
          fit: BoxFit.contain,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            final int? total = progress.expectedTotalBytes;
            return Center(
              child: SizedBox(
                width: width * 0.25,
                height: width * 0.25,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  value: total == null
                      ? null
                      : progress.cumulativeBytesLoaded / total,
                ),
              ),
            );
          },
          // Tải lỗi: vẽ ảnh dự phòng bằng code.
          errorBuilder: (context, error, stackTrace) =>
              _FallbackImage(product: product, width: width),
        ),
      ),
    );
  }
}

class _FallbackImage extends StatelessWidget {
  final Product product;
  final double width;

  const _FallbackImage({required this.product, required this.width});

  @override
  Widget build(BuildContext context) {
    final double dot = width * 0.07;

    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: product.colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Center(
          child: Icon(
            product.icon,
            size: width * 0.34,
            color: Colors.white.withValues(alpha: 0.85),
          ),
        ),
        Positioned(
          left: width * 0.06,
          top: width * 0.06,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _CameraDot(size: dot),
              SizedBox(height: dot * 0.5),
              _CameraDot(size: dot),
            ],
          ),
        ),
      ],
    );
  }
}

class _CameraDot extends StatelessWidget {
  final double size;

  const _CameraDot({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Color(0xFF212121),
        shape: BoxShape.circle,
      ),
    );
  }
}

class DiscountBadge extends StatelessWidget {
  final int percent;
  final double fontSize;

  const DiscountBadge({super.key, required this.percent, this.fontSize = 12});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: fontSize * 0.7,
        vertical: fontSize * 0.3,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE53935),
        borderRadius: BorderRadius.circular(fontSize * 0.6),
      ),
      child: Text(
        '-$percent%',
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
class PriceRow extends StatelessWidget {
  final Product product;
  final double fontSize;

  const PriceRow({super.key, required this.product, this.fontSize = 16});

  @override
  Widget build(BuildContext context) {
    return Text(
      product.priceText,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: const Color(0xFFE53935),
      ),
    );
  }
}
