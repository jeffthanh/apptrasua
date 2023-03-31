import 'package:flutter/material.dart';

import '../../products/ProductScreen.dart';
import '../../products/product_order.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 160,
            height: 160,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const ProductScreen();
                    },
                  ),
                );
              },
              child: Image.asset(
                "assets/images/menu/ts.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 160,
            height: 160,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const MyWidget();
                    },
                  ),
                );
              },
              child: Image.asset(
                "assets/images/menu/b.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
