import 'dart:convert';

import 'package:crud_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UpdateProductScreen extends StatefulWidget {
  final Product product;
  const UpdateProductScreen({super.key, required this.product});
  static const String name = '/update_product';

  @override
  State<UpdateProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<UpdateProductScreen> {
  final TextEditingController _nameTEcontroller = TextEditingController();
  final TextEditingController _imageTEcontroller = TextEditingController();
  final TextEditingController _priceTEcontroller = TextEditingController();
  final TextEditingController _TotalpriceTEcontroller = TextEditingController();
  final TextEditingController _quantityTEcontroller = TextEditingController();
  final TextEditingController _productcodeTEcontroller =
      TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _updateProductInProgress = false;
  @override
  void initState() {
    super.initState();
    _nameTEcontroller.text = widget.product.productName ?? '';
    _priceTEcontroller.text = widget.product.unitPrice ?? '';
    _TotalpriceTEcontroller.text = widget.product.totalPrice ?? '';
    _quantityTEcontroller.text = widget.product.quantity ?? '';
    _imageTEcontroller.text = widget.product.image ?? '';
    _productcodeTEcontroller.text = widget.product.productCode ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.3),
        child: _buildProductForm(),
      ),
    );
  }

  Widget _buildProductForm() {
    return Form(
      //TODO : (complete form validation )//validation complete
      key: _formkey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: _nameTEcontroller,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration:
                  InputDecoration(hintText: 'name', labelText: "Product Name"),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return "Enter product name";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _priceTEcontroller,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                  hintText: 'Price', labelText: "Product price"),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return "Enter product price";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _TotalpriceTEcontroller,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                  hintText: 'Total price', labelText: "Product Total price"),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return "Enter product total price";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _quantityTEcontroller,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                  hintText: 'Quantity', labelText: "Product quantity"),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return "Enter product Quantity";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _productcodeTEcontroller,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                  hintText: 'Product code', labelText: "Product  code"),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return "Enter product code";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _imageTEcontroller,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                  hintText: 'Iamge url', labelText: "Product  Image"),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return "Enter product Image";
                }
                return null;
              },
            ),
            SizedBox.square(),
            Visibility(
              visible: _updateProductInProgress == false,
              replacement: Center(
                child: CircularProgressIndicator(),
              ),
              child: ElevatedButton(
                  onPressed: () {
                    // TODO: validation cheak // validation cheak complete
                    if (_formkey.currentState!.validate()) {
                      _updateProduct();
                    }
                  },
                  child: const Text("Update Product")),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _updateProduct() async {
    _updateProductInProgress = true;
    setState(() {});
    Uri uri = Uri.parse(
        'https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product.id}');
    Map<String, dynamic> requestbody = {
      "Img": _imageTEcontroller.text.trim(),
      "ProductCode": _productcodeTEcontroller.text.trim(),
      "ProductName": _nameTEcontroller.text.trim(),
      "Qty": _quantityTEcontroller.text.trim(),
      "TotalPrice": _TotalpriceTEcontroller.text.trim(),
      "UnitPrice": _priceTEcontroller.text.trim(),
    };
    Response response = await post(
      uri,
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(requestbody),
    );
    print(response.statusCode);
    print(response.body);
    _updateProductInProgress = false;
    setState(() {});
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(" Product Updated!"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Product Updated failed . Try again!"),
        ),
      );
    }
  }

  @override
  void dispose() {
    _imageTEcontroller.dispose();
    _nameTEcontroller.dispose();
    _productcodeTEcontroller.dispose();
    _priceTEcontroller.dispose();
    _TotalpriceTEcontroller.dispose();
    _quantityTEcontroller.dispose();
    super.dispose();
  }
}
