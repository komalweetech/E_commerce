// ignore_for_file: file_names

class FavoriteItemModel {
  final String productId;
  final String productName;
  final String fullPrice;
  final List productImages;
  final String deliveryTime;
  final String productDescription;
  final dynamic createdAt;
  final dynamic updatedAt;

  FavoriteItemModel({
    required this.productId,
    required this.productName,
    required this.fullPrice,
    required this.productImages,
    required this.deliveryTime,
    required this.productDescription,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'fullPrice': fullPrice,
      'productImages': productImages,
      'deliveryTime': deliveryTime,
      'productDescription': productDescription,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory FavoriteItemModel.fromMap(Map<String, dynamic> json) {
    return FavoriteItemModel(
      productId: json['productId'],
      productName: json['productName'],
      fullPrice: json['fullPrice'],
      productImages: json['productImages'],
      deliveryTime: json['deliveryTime'],
      productDescription: json['productDescription'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}