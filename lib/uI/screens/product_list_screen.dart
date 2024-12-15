import 'dart:convert';

import 'package:crud_app/uI/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../models/product.dart';
import 'add_new_product_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> productlist = [];

  void initState() {
    super.initState();
    _getproductlist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product list"),
        actions: [
          IconButton(onPressed: (){
            _getproductlist();
          },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          _getproductlist();
        },
        child: ListView.builder(
          itemCount: productlist.length,
          itemBuilder: (context, index) {
            return ProductItem(product: productlist[index], onRefresh: () {  },);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddNewProductScreen.name);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _getproductlist() async {
    productlist.clear();
    Uri uri = Uri.parse('https://crud.teamrabbil.com/api/v1/ReadProduct');
    Response response = await get(uri);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final decodeData = jsonDecode(response.body);
      print(decodeData['status']);
      for (Map<String, dynamic> p in decodeData['data']) {
        Product product = Product(
            id: p['_id'],
            productName: p['ProductName'],
            productCode: p['Productcode'],
            image: p['Img'],
            unitPrice: p['UnitPrice'],
            quantity: p['Qty'],
            totalPrice: p['TotalPrice'],
            createData: p['CreatedDate']);
        productlist.add(product);
      }
      setState(() {

      });
    }
  }
}
