import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import '../../models/product_model.dart';
import '../../providers/cart_provider.dart';
import '../cart/cart.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final List<Product> items = [
    Product(
      id: "m1",
      title: "Bánh kem",
      description: "Vị tan mềm mại thơm ngon ",
      price: 23.000,
      imageUrl: "assets/images/products/b1.jpg",
      isFavorite: false,
    ),
    Product(
      id: "m2",
      title: "Bánh gato",
      description: "Xuất xứ nước ngoài mang lại hương vị mới lạ",
      price: 20.000,
      imageUrl: "assets/images/products/b2.jpg",
      isFavorite: false,
    ),
    Product(
      id: "m3",
      title: "Bánh da lợn",
      description: "Xuất xứ việt nam mang đến hương vị truyền thống ",
      price: 20.000,
      imageUrl: "assets/images/products/b3.jpg",
      isFavorite: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bánh Ngọt"),
        backgroundColor: Colors.green,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 20),
            child: Consumer<CartProvider>(
              builder: (context, value, child) {
                return badges.Badge(
                  badgeContent: Text('${value.items.length}'),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(CartPage.routerName);
                    },
                    child: const Icon(Icons.shopping_cart),
                  ),
                );
              },
            ),
          )
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GridTile(
              footer: GridTileBar(
                backgroundColor: Colors.black87,
                leading: ValueListenableBuilder<bool>(
                  valueListenable: items[index].isFavoriteListenable,
                  builder: (ctx, isFavorite, child) {
                    return IconButton(
                      icon: Icon(
                        items[index].isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                      onPressed: () {
                        items[index].isFavorite = !isFavorite;
                      },
                    );
                  },
                ),
                title: Text(
                  items[index].title,
                  textAlign: TextAlign.center,
                ),
                trailing: InkWell(
                  onTap: () {
                    Provider.of<CartProvider>(context, listen: false).addCart(
                        items[index].imageUrl,
                        items[index].title,
                        items[index].price,
                        1);
                  },
                  child: const Icon(Icons.shopping_cart),
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => Scaffold(
                        appBar: AppBar(
                          title: Text(items[index].title),
                          backgroundColor: Colors.green,
                        ),
                        body: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: [
                                SizedBox(
                                  height: 300,
                                  width: double.infinity,
                                  child: Image.asset(
                                    items[index].imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '\$${items[index].price}',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  width: double.infinity,
                                  child: Text(
                                    items[index].description,
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Image.asset(
                  items[index].imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
