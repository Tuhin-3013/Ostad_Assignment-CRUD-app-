

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DeleteFunction {
  static Future<bool> deleteProduct(String id, BuildContext context) async {
    final uri = Uri.parse("https://crud.teamrabbil.com/api/v1/DeleteProduct/$id");
    final response = await http.get(uri);
    print(response.statusCode);
    print(response.body);
    final decodedResponse = jsonDecode(response.body);

    if (response.statusCode == 200 && decodedResponse['status'] == 'success') {
      return true;
    }
    return false;
  }

  static Future<void> showDeleteConfirmation({
    required BuildContext context,
    required String id,
    required String productName,
    required String productCode,
    required String quantity,
    required String price,
    required String totalPrice,
    required VoidCallback onDeleteSuccess,
    String? imageUrl,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Are you sure? this product is deleted?',
          ),
          content: Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        productName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Product Code: $productCode',
                ),
                Text(
                  'Quantity: $quantity',
                ),
                Text(
                  'Price: $price',
                ),
                Text(
                  'Total Price: $totalPrice',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'NO',
                style: TextStyle(color: Colors.black87),
              ),
            ),
            TextButton(
              onPressed: () async {
                final success = await deleteProduct(id, context);
                if (success) {
                  Navigator.of(context).pop();
                  onDeleteSuccess();
                }
              },
              child: const Text(
                'YES',
              ),
            ),
          ],
          actionsPadding: const EdgeInsets.all(16),
        );
      },
    );
  }
}