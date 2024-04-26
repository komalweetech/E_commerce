// ignore_for_file: file_names

class OrderModel {
  final String productId;
  final String productName;
  final String fullPrice;
  final String productImage;
  final String size;
  final String deliveryTime;
  final String productDescription;
  final dynamic createdAt;
  final dynamic updatedAt;
  final int productQuantity;
  final double productTotalPrice;
  final String customerId;
  final bool orderStatus;
  final String customerName;
  final String customerPhone;
  final String customerAddress;
  final String customerDeviceToken;

  OrderModel({
    required this.productId,
    required this.productName,
    required this.fullPrice,
    required this.productImage,
    required this.size,
    required this.deliveryTime,
    required this.productDescription,
    required this.createdAt,
    required this.updatedAt,
    required this.productQuantity,
    required this.productTotalPrice,
    required this.customerId,
    required this.orderStatus,
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
    required this.customerDeviceToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'fullPrice': fullPrice,
      'productImage': productImage,
      'size' : size,
      'deliveryTime': deliveryTime,
      'productDescription': productDescription,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'productQuantity': productQuantity,
      'productTotalPrice': productTotalPrice,
      'customerId': customerId,
      'status': orderStatus,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'customerAddress': customerAddress,
      'customerDeviceToken': customerDeviceToken,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> json) {
    return OrderModel(
      productId: json['productId'],
      productName: json['productName'],
      fullPrice: json['fullPrice'],
      productImage: json['productImage'],
      size: json['size'],
      deliveryTime: json['deliveryTime'],
      productDescription: json['productDescription'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      productQuantity: json['productQuantity'],
      productTotalPrice: json['productTotalPrice'],
      customerId: json['customerId'],
      orderStatus: json['status'],
      customerName: json['customerName'],
      customerPhone: json['customerPhone'],
      customerAddress: json['customerAddress'],
      customerDeviceToken: json['customerDeviceToken'],
    );
  }
}