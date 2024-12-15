class Product {
  String? id;
  String? productName;
  String? productCode;
  String? image;
  String? unitPrice;
  String? quantity;
  String? totalPrice;
  String? createData;

  Product({
    required this.id,
    required this.productName,
    required this.productCode,
    required this.image,
    required this.unitPrice, // This parameter should be defined
    required this.quantity,
    required this.totalPrice,
    required this.createData,
  });

}
