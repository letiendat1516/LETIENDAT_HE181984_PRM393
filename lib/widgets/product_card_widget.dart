import 'package:flutter/material.dart';

import 'product_widget.dart';

/// Một dòng sản phẩm trong danh sách: ảnh - tên - giá - nhãn giảm giá.
class ProductCardWidget extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCardWidget({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                SizedBox(
                  width: 76,
                  height: 100,
                  child: Center(
                    child: ProductWidget(product: product, width: 70),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      PriceRow(product: product),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    product.isSaved ? Icons.bookmark : Icons.bookmark_border,
                    color: product.isSaved ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    // Handle save action
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
