import 'package:crud_app/uI/screens/add_new_product_screen.dart';
import 'package:crud_app/uI/screens/product_list_screen.dart';
import 'package:crud_app/uI/screens/update_produc_screen.dart';
import 'package:flutter/material.dart';

import 'models/product.dart';

class CRUDapp extends StatelessWidget {
  const CRUDapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        late Widget widget;

        if (settings.name == '/') {
          widget = ProductListScreen();
        } else if (settings.name == AddNewProductScreen.name) {
          widget = AddNewProductScreen();
        } else if (settings.name == UpdateProductScreen.name) {
          final Product product = settings.arguments as Product;
          widget = UpdateProductScreen(product: product);
        } else {
          // Default case for undefined routes
          widget = Scaffold(
            appBar: AppBar(
              title: const Text('Page Not Found'),
            ),
            body: const Center(
              child: Text('404 - Page Not Found'),
            ),
          );
        }

        return MaterialPageRoute(
          builder: (context) {
            return widget;
          },
        );
      },
    );
  }
}
