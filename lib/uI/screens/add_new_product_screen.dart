import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({super.key});
  static const String name = '/add_new';
  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  final TextEditingController _nameTEcontroller = TextEditingController();
  final TextEditingController _imageTEcontroller = TextEditingController();
  final TextEditingController _priceTEcontroller = TextEditingController();
  final TextEditingController _TotalpriceTEcontroller = TextEditingController();
  final TextEditingController _quantityTEcontroller = TextEditingController();
  final TextEditingController _productcodeTEcontroller =
      TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _addNewproductInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.3),
        child: _buildProductForm(),
      ),
    );
  }

  Widget _buildProductForm() {
    return Form(
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
              keyboardType: TextInputType.number,
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
              keyboardType: TextInputType.number,
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
              visible: _addNewproductInProgress == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      _addNewproduct();
                    }
                  },
                  child: const Text("Add Product")),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _addNewproduct() async {
    _addNewproductInProgress = true;
    setState(() {});
    Uri uri = Uri.parse('https://crud.teamrabbil.com/api/v1/CreateProduct');
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
    _addNewproductInProgress=false;
    setState(() {
    });
    if (response.statusCode == 200) {
      _clearTextFiled();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("New product added!"),
        ),
      );
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("New product added failed . Try again!"),
        ),
      );
    }
  }

  void _clearTextFiled() {
    _imageTEcontroller.clear();
    _nameTEcontroller.clear();
    _productcodeTEcontroller.clear();
    _priceTEcontroller.clear();
    _TotalpriceTEcontroller.clear();
    _quantityTEcontroller.clear();
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
