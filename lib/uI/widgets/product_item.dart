import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/product.dart';
import '../screens/delete_function.dart';
import '../screens/update_produc_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product, required this.onRefresh });

  final Product product;

  final Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        product.image ?? '',
        width: 40,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      ),
      title: Text(product.productName ?? ''),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Product code: ${product.productCode ?? 'N/A'}"),
          Text("Quantity: ${product.quantity ?? ''}"),
          Text("Per price: ${product.unitPrice ?? ''}"),
          Text("Total price: ${product.totalPrice ?? ''}"),
        ],
      ),
      trailing: Wrap(
        children: [
      IconButton(
      padding: EdgeInsets.zero,
        onPressed: () {
          DeleteFunction.showDeleteConfirmation(
            context: context,
            id: product.id ?? '',
            productName: product.productName ?? 'Unknown',
            productCode: product.productCode ?? 'Unknown',
            quantity: product.quantity?.toString() ?? 'Unknown',
            price: product.unitPrice?.toString() ?? 'Unknown',
            totalPrice: product.totalPrice?.toString() ?? 'Unknown',
            imageUrl: product.image,
            onDeleteSuccess: onRefresh,
          );
        },
        icon: const Icon(Icons.delete,),
      ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                UpdateProductScreen.name,
                arguments: product,
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
    );
  }
}
