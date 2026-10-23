import 'package:flutter/foundation.dart';
import '../models/product.dart';

class CartLine {
  const CartLine({
    required this.product,
    required this.quantity,
    required this.color,
    required this.storage,
  });
  final Product product;
  final int quantity, color;
  final String storage;
  String get key => '${product.id}-$color-$storage';
  CartLine copyWith(int quantity) => CartLine(
    product: product,
    quantity: quantity,
    color: color,
    storage: storage,
  );
}

class ShopStore extends ChangeNotifier {
  final List<CartLine> _cart = [];
  final Set<String> _favorites = {};
  int orders = 0;
  List<CartLine> get cart => List.unmodifiable(_cart);
  int get cartCount => _cart.fold(0, (sum, line) => sum + line.quantity);
  int get subtotal =>
      _cart.fold(0, (sum, line) => sum + line.product.price * line.quantity);
  int get favoriteCount => _favorites.length;
  bool isFavorite(String id) => _favorites.contains(id);

  void toggleFavorite(String id) {
    if (!_favorites.add(id)) _favorites.remove(id);
    notifyListeners();
  }

  void add(
    Product product, {
    int color = 0,
    String? storage,
    int quantity = 1,
  }) {
    final item = CartLine(
      product: product,
      quantity: quantity,
      color: color,
      storage: storage ?? product.storage.first,
    );
    final index = _cart.indexWhere((line) => line.key == item.key);
    if (index == -1) {
      _cart.add(item);
    } else {
      _cart[index] = _cart[index].copyWith(_cart[index].quantity + quantity);
    }
    notifyListeners();
  }

  void changeQuantity(String key, int difference) {
    final index = _cart.indexWhere((line) => line.key == key);
    if (index == -1) return;
    final quantity = _cart[index].quantity + difference;
    if (quantity <= 0) {
      _cart.removeAt(index);
    } else {
      _cart[index] = _cart[index].copyWith(quantity);
    }
    notifyListeners();
  }

  void checkout() {
    if (_cart.isEmpty) return;
    _cart.clear();
    orders++;
    notifyListeners();
  }
}
