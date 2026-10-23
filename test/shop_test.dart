import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phone_remote/app.dart';
import 'package:phone_remote/data/mock_products.dart';
import 'package:phone_remote/state/shop_store.dart';

void main() {
  test('giỏ hàng gộp sản phẩm cùng phiên bản và tính tổng tiền', () {
    final store = ShopStore();
    final product = mockProducts.first;
    store.add(product, quantity: 2);
    store.add(product);
    expect(store.cartCount, 3);
    expect(store.subtotal, product.price * 3);
    store.changeQuantity(store.cart.first.key, -1);
    expect(store.cartCount, 2);
    store.checkout();
    expect(store.cartCount, 0);
    expect(store.orders, 1);
  });

  testWidgets('mở chi tiết và thêm sản phẩm vào giỏ', (tester) async {
    await tester.pumpWidget(const PhoneStoreApp());
    expect(find.text('mobizone.'), findsOneWidget);
    await tester.tap(find.text('Khám phá ngay  →'));
    await tester.pumpAndSettle();
    expect(find.text('Chi tiết sản phẩm'), findsOneWidget);
    await tester.tap(find.text('Thêm vào giỏ'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Đã thêm 1 sản phẩm'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.shopping_bag_outlined).first);
    await tester.pumpAndSettle();
    expect(find.text('Giỏ hàng'), findsWidgets);
    expect(find.text('iPhone 16 Pro'), findsOneWidget);
  });
}
