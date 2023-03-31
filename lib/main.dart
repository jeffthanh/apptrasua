import 'package:flutter/material.dart';
import 'package:project/pages/favorite/favorite.dart';
import 'package:project/pages/home/HomePage.dart';

import 'package:provider/provider.dart';

import 'ui/screens.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthManager(),
        ),
        ChangeNotifierProxyProvider<AuthManager, ProductsManager>(
          create: (ctx) => ProductsManager(),
          update: (ctx, authManager, productsManager) {
// Khi authManager có báo hiệu thay đổi thì đọc lại authToken
// cho productManager
            productsManager!.authToken = authManager.authToken;
            return productsManager;
          },
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrdersManager(),
        )
      ],
      child: Consumer<AuthManager>(builder: (context, authManager, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: authManager.isAuth
              ? const HomePage()
              : FutureBuilder(
                  future: authManager.tryAutoLogin(),
                  builder: (context, snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? const SplashScreen()
                        : const AuthScreen();
                  },
                ),
          routes: {
            UserProductsScreen.routerName: (context) =>
                const UserProductsScreen(),
            CartPage.routerName: (context) => const CartPage(),
            OrdersScreen.routerName: (context) => const OrdersScreen(),
            FavoriteBody.routerName: (context) => const FavoriteBody(),
          },
          onGenerateRoute: (settings) {
            if (settings.name == ProductDetailScreen.routerName) {
              final productId = settings.arguments as String;
              return MaterialPageRoute(
                builder: (ctx) {
                  return ProductDetailScreen(
                    ctx.read<ProductsManager>().findById(productId)!,
                  );
                },
              );
            }
            if (settings.name == EditProductScreen.routerName) {
              final productId = settings.arguments as String?;
              return MaterialPageRoute(
                builder: (ctx) {
                  return EditProductScreen(
                    productId != null
                        ? ctx.read<ProductsManager>().findById(productId)
                        : null,
                  );
                },
              );
            }
            return null;
          },
        );
      }),
    );
  }
}
