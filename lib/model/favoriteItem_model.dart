// ignore_for_file: file_names

class FavoriteItemModel {
  final String productId;
  final String productName;
  final String fullPrice;
  final List productImages;
  final String deliveryTime;
  final String productDescription;
  final List size;
  final dynamic createdAt;
  final dynamic updatedAt;
  bool isFavorite;

  FavoriteItemModel({
    required this.productId,
    required this.productName,
    required this.fullPrice,
    required this.productImages,
    required this.deliveryTime,
    required this.productDescription,
    required this.size,
    required this.createdAt,
    required this.updatedAt,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'fullPrice': fullPrice,
      'productImages': productImages,
      'deliveryTime': deliveryTime,
      'productDescription': productDescription,
      'size' : size,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isFavorite': isFavorite,
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
      size : json['size'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}