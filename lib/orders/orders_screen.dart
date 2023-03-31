import 'package:flutter/material.dart';
import 'package:project/orders/order_manager.dart';
import 'package:provider/provider.dart';

import '../pages/home/widgets/DrawerWidget.dart';
import 'order_item_card.dart';

class OrdersScreen extends StatelessWidget {
  static const routerName = '/orders';
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('building orders');
    final ordersManager = OrdersManager();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
        backgroundColor: Colors.green,
      ),
      drawer: const DrawerWidget(),
      body: Consumer<OrdersManager>(
        builder: (ctx, ordersManager, child) {
          return ListView.builder(
            itemCount: ordersManager.orderCount,
            itemBuilder: (ctx, i) => OrderItemCard(ordersManager.orders[i]),
          );
        },
      ),
    );
  }
}
