import 'package:flutter/material.dart';

import '../models/order_item.dart';
import '../providers/cart_provider.dart';

class OrdersManager with ChangeNotifier {
  final List<OrderItem> _orders = [
    OrderItem(
      id: 'o1',
      amount: 46.0,
      products: [
        CartItem(
          image: "assets/images/products/ts1.jpg",
          title: 'trà sữa khoai môn',
          quantity: 2,
          price: 23.000,
        )
      ],
      dateTime: DateTime.now(),
    )
  ];
  int get orderCount {
    return _orders.length;
  }

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) async {
    _orders.insert(
      0,
      OrderItem(
        id: 'o${DateTime.now().toIso8601String()}',
        amount: total,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
