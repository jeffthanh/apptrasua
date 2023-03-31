import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  Map<String, CartItem> items = {};

  void addCart(String image, String title, double price, int quantity) {
    if (items.containsKey(title)) {
      items.update(
        title,
        (value) => CartItem(
          image: value.image,
          title: value.title,
          price: value.price,
          quantity: value.quantity + quantity,
        ),
      );
    } else {
      items.putIfAbsent(
        title,
        () => CartItem(
          image: image,
          title: title,
          price: price,
          quantity: quantity,
        ),
      );
    }
    notifyListeners();
  }

  void inCrease(String title, int quantity) {
    items.update(
      title,
      (value) => CartItem(
        image: value.image,
        title: value.title,
        price: value.price,
        quantity: value.quantity + quantity,
      ),
    );
    notifyListeners();
  }

  void deCrease(String title, int quantity) {
    if (items[title]?.quantity == 1) {
      items.removeWhere((key, value) => key == title);
    } else {
      items.update(
        title,
        (value) => CartItem(
          image: value.image,
          title: value.title,
          price: value.price,
          quantity: value.quantity - quantity,
        ),
      );
    }

    notifyListeners();
  }

  double get totalAmount {
    var total = 0.0;
    items.forEach((key, CartItem) {
      total += CartItem.price * CartItem.quantity;
    });
    return total;
  }

  void clear() {
    items = {};
    notifyListeners();
  }

  List<CartItem> get products {
    return items.values.toList();
  }
}

class CartItem {
  final String image;
  final String title;
  final double price;
  final int quantity;

  CartItem(
      {required this.image,
      required this.title,
      required this.price,
      required this.quantity});
}
