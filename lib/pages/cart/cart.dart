import 'package:flutter/material.dart';
import 'package:project/providers/cart_provider.dart';
import 'package:provider/provider.dart';

import '../../orders/order_manager.dart';

class CartPage extends StatelessWidget {
  static const routerName = '/cart';
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trang giỏ hàng"),
        backgroundColor: Colors.green,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 20),
            child: Consumer<CartProvider>(
              builder: (context, value, child) {
                return Text(
                  '\$${Provider.of<CartProvider>(context, listen: false).totalAmount.toStringAsFixed(2)}',
                );
              },
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Consumer<CartProvider>(
              builder: (context, value, child) {
                var dataItem = value.items.values.toList();
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.asset(
                        width: 50,
                        height: 50,
                        dataItem[index].image,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        dataItem[index].title,
                        maxLines: 1,
                      ),
                      subtitle: Text(
                        (dataItem[index].price * dataItem[index].quantity)
                            .toString(),
                      ),
                      trailing: SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        child: Row(
                          children: [
                            InkWell(
                              child: const Icon(Icons.remove),
                              onTap: () {
                                Provider.of<CartProvider>(context,
                                        listen: false)
                                    .deCrease(
                                        value.items.keys.toList()[index], 1);
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${dataItem[index].quantity}'),
                            ),
                            InkWell(
                              child: const Icon(Icons.add),
                              onTap: () {
                                Provider.of<CartProvider>(context,
                                        listen: false)
                                    .inCrease(
                                        value.items.keys.toList()[index], 1);
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: value.items.length,
                );
              },
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: TextButton(
              onPressed: Provider.of<CartProvider>(context, listen: false)
                          .totalAmount <=
                      0
                  ? null
                  : () {
                      context.read<OrdersManager>().addOrder(
                            Provider.of<CartProvider>(context, listen: false)
                                .products,
                            Provider.of<CartProvider>(context, listen: false)
                                .totalAmount,
                          );
                      Provider.of<CartProvider>(context, listen: false).clear();
                    },
              child: const Text('Mua hàng'),
            ),
          ),
        ],
      ),
    );
  }
}
