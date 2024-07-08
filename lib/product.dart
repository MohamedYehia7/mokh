import 'package:mokh/unit.dart';

class Product {
  int? lineNo;
  String? productName;
  Unit? unit;
  int? unitNo;
  int? price;
  int? quantity;
  int? total;
  String? expiryDate;

  Product(
      {this.lineNo,
        this.productName,
        this.unit,
        this.unitNo,
        this.price,
        this.quantity,
        this.total,
        this.expiryDate});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      lineNo: json['lineNo'],
      productName: json['productName'],
      unit: json['unit'],
      unitNo: json['unitNo'],
      price: json['price'],
      quantity: json['quantity'],
      total: json['total'],
      expiryDate: json['expiryDate'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lineNo'] = this.lineNo;
    data['productName'] = this.productName;
    data['unit'] = this.unit;
    data['unitNo'] = this.unitNo;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['total'] = this.total;
    data['expiryDate'] = this.expiryDate;
    return data;
  }
}
