import 'package:flutter/material.dart';
import 'package:project/pages/products/products_manager.dart';
import 'package:provider/provider.dart';

class FavoriteBody extends StatelessWidget {
  static const routerName = '/favorite';
  const FavoriteBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var items = Provider.of<ProductsManager>(context).favoriteItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sản phẩm yêu thích"),
        backgroundColor: Colors.green,
      ),
      body: Consumer<ProductsManager>(
        builder: (context, value, child) {
          return SafeArea(
            child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                  confirmDismiss: (direction) async {
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Delete Product'),
                        content: const Text('Are You Sure Delete ?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    );
                  },
                  onDismissed: (direction) {
                    items[index].handleRemoveIsFavorite();
                  },
                  key: ValueKey<int>(index),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 140,
                      child: GridTile(
                        footer: GridTileBar(
                          title: Text(
                            items[index].title,
                            style: const TextStyle(color: Colors.black),
                          ),
                          trailing: const Icon(
                            Icons.swipe,
                          ),
                          backgroundColor: Colors.white70,
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 140,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(items[index].imageUrl),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
