import 'package:intl/intl.dart';

class CartModel {
  final String productId;
  final String productName;
  final String fullPrice;
  final String productImage;
  final String deliveryTime;
  final String productDescription;
  final dynamic createdAt;
  final dynamic updatedAt;
  final int productQuantity;
  final double productTotalPrice;
  final String size;

  CartModel({
    required this.productId,
    required this.productName,
    required this.fullPrice,
    required this.productImage,
    required this.deliveryTime,
    required this.productDescription,
    required this.createdAt,
    required this.updatedAt,
    required this.productQuantity,
    required this.productTotalPrice,
    required this.size,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'fullPrice': fullPrice,
      'productImage': productImage,
      'deliveryTime': deliveryTime,
      'productDescription': productDescription,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'productQuantity': productQuantity,
      'productTotalPrice': productTotalPrice,
      'size' : size,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> json) {
    return CartModel(
      productId: json['productId'],
      productName: json['productName'],
      fullPrice: json['fullPrice'],
      productImage: json['productImage'],
      deliveryTime: json['deliveryTime'],
      productDescription: json['productDescription'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      productQuantity: json['productQuantity'],
      productTotalPrice: json['productTotalPrice'],
      size: json['size'],
    );
  }
}