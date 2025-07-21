import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final String image;
  final double price;
  int quantity;
  final String size;
  final Color? selectedColor;

  CartItem({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    this.quantity = 1,
    required this.size,
    this.selectedColor,
  });

  double get totalPrice => price * quantity;
}

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.length;

  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  void addItem({
    required String productId,
    required String title,
    required String image,
    required double price,
    required String size,
    Color? selectedColor,
  }) {
    final existingIndex = _items.indexWhere(
      (item) =>
          item.id == productId &&
          item.size == size &&
          item.selectedColor == selectedColor,
    );

    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(
        CartItem(
          id: productId,
          title: title,
          image: image,
          price: price,
          size: size,
          selectedColor: selectedColor,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId, String size, Color? selectedColor) {
    _items.removeWhere(
      (item) =>
          item.id == productId &&
          item.size == size &&
          item.selectedColor == selectedColor,
    );
    notifyListeners();
  }

  void updateQuantity(
    String productId,
    String size,
    Color? selectedColor,
    int quantity,
  ) {
    final existingIndex = _items.indexWhere(
      (item) =>
          item.id == productId &&
          item.size == size &&
          item.selectedColor == selectedColor,
    );

    if (existingIndex >= 0) {
      if (quantity <= 0) {
        _items.removeAt(existingIndex);
      } else {
        _items[existingIndex].quantity = quantity;
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  bool isInCart(String productId, String size, Color? selectedColor) {
    return _items.any(
      (item) =>
          item.id == productId &&
          item.size == size &&
          item.selectedColor == selectedColor,
    );
  }
}
