import 'package:flutter/material.dart';
import 'package:labflutter/models/product.dart';

class ProductWidget extends StatelessWidget {
  final Product product;

  const ProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ảnh cố định chiều cao
          SizedBox(
            width: double.infinity,
            height: 300,
            child: product.image != null
                ? Image.asset(
                    'assets/images/${product.image}',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        _imagePlaceholder(),
                  )
                : _imagePlaceholder(),
          ),
          // Thông tin sản phẩm
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                if (product.description != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    product.description!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
                const SizedBox(height: 4),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 13,
                      color: Colors.green,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    // Xử lý khi nhấn nút
                  },
                  child: const Text('Mua ngay'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(50), // Chiều cao tối thiểu
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      color: Colors.grey[200],
      child: const Center(
        child: Icon(Icons.image_not_supported, size: 36, color: Colors.grey),
      ),
    );
  }
}