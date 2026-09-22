import 'package:flutter/material.dart';

// Exercise 1 - Core Widgets: Text, Image, Icon, Card, ListTile
class CoreWidgetsDemo extends StatelessWidget {
  const CoreWidgetsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Core Widgets Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Headline Text
            const Text(
              'Chào mừng đến với Flutter!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Icon dùng Material Icons
            const Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 32),
                SizedBox(width: 8),
                Text('Material Icon: Icons.star'),
              ],
            ),
            const SizedBox(height: 16),
            // Image.network - ảnh tải từ internet
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'https://picsum.photos/400/200',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context, error, stackTrace) => const SizedBox(
                  height: 200,
                  child: Center(child: Icon(Icons.broken_image, size: 48)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Card chứa ListTile
            Card(
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.person, color: Colors.blue),
                title: const Text('Nguyễn Văn A'),
                subtitle: const Text('Sinh viên - FPT University'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
