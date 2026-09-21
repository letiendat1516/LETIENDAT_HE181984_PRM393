import 'package:flutter/material.dart';
import 'package:labflutter/models/product.dart';
import 'package:labflutter/UI/Widgets/ProductWidget.dart';

class Bodywidget extends StatelessWidget {
  Bodywidget({super.key});

  // Danh sách sản phẩm mẫu
  final List<Product> products = [
    Product(id: 1, name: 'iPhone 17', price: 25000000, quantity: 10,
        image: '0002.jpg', description: 'Điện thoại Apple mới nhất'),
    Product(id: 2, name: 'Samsung Galaxy S25', price: 18000000, quantity: 5,
        image: '0002.jpg', description: 'Flagship Android cao cấp'),
    Product(id: 3, name: 'MacBook Pro M4', price: 55000000, quantity: 3,
        image: '0003.jpg', description: 'Laptop mạnh mẽ cho lập trình viên'),
    Product(id: 4, name: 'AirPods Pro 3', price: 6000000, quantity: 20,
        image: '0004.jpg', description: 'Tai nghe chống ồn chủ động'),
    Product(id: 5, name: 'iPad Pro M4', price: 28000000, quantity: 8,
        image: '0005.jpg', description: 'Máy tính bảng cao cấp'),
    Product(id: 6, name: 'Apple Watch S10', price: 12000000, quantity: 15,
        image: '0006.jpg', description: 'Đồng hồ thông minh'),
    Product(id: 7, name: 'Sony WH-1000XM6', price: 8000000, quantity: 12,
        image: '0007.jpg', description: 'Tai nghe over-ear chống ồn'),
    Product(id: 8, name: 'Apple TV 4K', price: 4500000, quantity: 25,
        image: '0014.jpg', description: 'Thiết bị stream 4K'),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,      // tối đa 4 card mỗi hàng
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        mainAxisExtent: 440,    // chiều cao cố định vừa khít nội dung
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductWidget(product: products[index]);
      },
    );
  }
}