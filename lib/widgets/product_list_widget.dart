import 'package:flutter/material.dart';

import 'product_card_widget.dart';
import 'product_widget.dart';

/// Layer 1: ô tìm kiếm + danh sách sản phẩm.
class ProductListWidget extends StatefulWidget {
  final List<Product> products;

  /// Gọi khi bấm vào một sản phẩm (để chuyển sang tab Product Detail).
  final ValueChanged<Product>? onSelect;

  const ProductListWidget({super.key, required this.products, this.onSelect});

  @override
  State<ProductListWidget> createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
  final TextEditingController _searchController = TextEditingController();
  String _keyword = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Product> get _filtered {
    if (_keyword.trim().isEmpty) return widget.products;
    final String key = _keyword.toLowerCase().trim();
    return widget.products
        .where((p) => p.name.toLowerCase().contains(key))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final List<Product> items = _filtered;

    return Column(
      children: [
        // Ô tìm kiếm.
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
          child: TextField(
            controller: _searchController,
            onChanged: (value) => setState(() => _keyword = value),
            decoration: InputDecoration(
              hintText: 'Search products...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 4),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        // Danh sách sản phẩm.
        Expanded(
          child: items.isEmpty
              ? const Center(
                  child: Text(
                    'No product found',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(top: 4, bottom: 12),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final Product product = items[index];
                    return ProductCardWidget(
                      product: product,
                      onTap: () => widget.onSelect?.call(product),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
