import 'package:flutter/material.dart';

import '../widgets/product_detail_widget.dart';
import '../widgets/product_list_widget.dart';
import '../widgets/product_widget.dart';

/// Màn hình chính: gồm 3 layer đổi qua lại bằng BottomNavigationBar.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Tab đang chọn: 0 = Home, 1 = Product Detail, 2 = Cart.
  int index = 0;

  /// Sản phẩm đang xem chi tiết.
  Product? selectedProduct;

  /// Giỏ hàng.
  final List<Product> cart = [];

  static const List<String> _titles = ['Products', 'Product Detail', 'Cart'];

  void _selectProduct(Product product) {
    setState(() {
      selectedProduct = product;
      index = 1; // chuyển sang layer2
    });
  }

  void _addToCart(Product product) {
    setState(() {
      cart.add(product);
      index = 2; // chuyển sang layer3
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã thêm ${product.name} vào giỏ hàng'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _removeFromCart(Product product) {
    setState(() => cart.remove(product));
  }

  @override
  Widget build(BuildContext context) {
    // Layer 1: danh sách sản phẩm.
    final Widget layer1 = ProductListWidget(
      products: sampleProducts,
      onSelect: _selectProduct,
    );

    // Layer 2: chi tiết sản phẩm.
    final Widget layer2 = ProductDetailWidget(
      product: selectedProduct,
      onAddToCart: _addToCart,
    );

    // Layer 3: giỏ hàng.
    final Widget layer3 = CartWidget(items: cart, onRemove: _removeFromCart);

    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[index]),
        centerTitle: true,
        backgroundColor: const Color(0xFF1E88E5),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: _AppDrawer(),
      body: [layer1, layer2, layer3][index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) => setState(() => index = value),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF1E88E5),
        unselectedItemColor: Colors.grey,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: 'Courses',
          ),
          const BottomNavigationBarItem(
              icon: Icon(Icons.folder),
              label: 'My Learning',
            ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _AppDrawer extends StatelessWidget {
  static const List<_CategoryItem> _categories = [
    _CategoryItem(icon: Icons.home, label: 'All Courses'),
    _CategoryItem(icon: Icons.phone_android, label: 'Mobile Development'),
    _CategoryItem(icon: Icons.web, label: 'Web Development'),
    _CategoryItem(icon: Icons.smart_toy, label: 'Artificial Intelligence'),
    _CategoryItem(icon: Icons.design_services, label: 'UI/UX Design'),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF1E88E5)),
            accountName: const Text(
              'Nguyễn Văn A',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            accountEmail: const Text('nguyenvana@example.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 40,
                color: const Color(0xFF1E88E5),
              ),
            ),
          ),

          for (final item in _categories)
            ListTile(
              leading: Icon(item.icon, color: const Color(0xFF1E88E5)),
              title: Text(item.label),
              onTap: () => Navigator.pop(context),
            ),

          const Divider(),
          const Spacer(),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 12),

        ],
      ),
    );
  }
}

class _CategoryItem {
  final IconData icon;
  final String label;
  const _CategoryItem({required this.icon, required this.label});
}

class CartWidget extends StatelessWidget {
  final List<Product> items;
  final ValueChanged<Product>? onRemove;

  const CartWidget({super.key, required this.items, this.onRemove});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 12),
            Text(
              'Giỏ hàng đang trống',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      );
    }

    final double total = items.fold(0, (sum, p) => sum + p.price);

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: items.length,
            itemBuilder: (context, i) {
              final Product p = items[i];
              return ListTile(
                leading: SizedBox(
                  width: 40,
                  child: ProductWidget(product: p, width: 36),
                ),
                title: Text(
                  p.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(p.priceText),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () => onRemove?.call(p),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '\$${total.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE53935),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
