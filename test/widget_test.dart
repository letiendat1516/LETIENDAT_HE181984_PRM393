import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:projectpt1/app.dart';

void main() {
  testWidgets('App khởi động hiển thị bottom navigation Photos + Wishlist',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: App()),
    );
    await tester.pump();

    expect(find.text('Photos'), findsWidgets);
    expect(find.text('Wishlist'), findsWidgets);
    expect(find.byIcon(Icons.photo_library_outlined), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsWidgets);
  });
}
