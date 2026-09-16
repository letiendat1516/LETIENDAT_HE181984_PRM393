import 'package:flutter/material.dart';

class Bodywidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Hello',
                  style: TextStyle(fontSize: 24, color: Colors.red, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, letterSpacing: 2.0, wordSpacing: 4.0, height: 1.5, decoration: TextDecoration.underline, decorationColor: Colors.blue, decorationStyle: TextDecorationStyle.dashed),
                ),
                TextSpan(
                  text: ', ',
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
                TextSpan(
                  text: 'World!',
                  style: TextStyle(fontSize: 24, color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          // ---- ảnh local từ assets ----
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/0014.jpg',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_photo_alternate, size: 48, color: Colors.grey),
                        SizedBox(height: 8),
                        Text(
                          'Thêm ảnh vào:\nassets/images/0014.jpg',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey[600], fontSize: 13),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 24),
          // ---- ảnh network ----
          Container(
            constraints: BoxConstraints(maxWidth: 300),
            child: Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRO4vv3RgB2Vw6oxUaI3-PE8xLIfBkMkPhj_Xj3Nac4Mw&s=10',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: Icon(Icons.image_not_supported),
                );
              },
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}