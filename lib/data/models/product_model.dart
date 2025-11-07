import '../../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required String id,
    required String name,
    required String imageUrl,
    required double price,
    String description = '',
    String brand = '',
    List<String> categories = const [],
    String productTitle = '',
  }) : super(
          id: id,
          name: name,
          imageUrl: imageUrl,
          price: price,
          description: description,
          brand: brand,
          categories: categories,
          productTitle: productTitle,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final items = json['items'] as List<dynamic>?;
    String image = '';
    double price = 0.0;

    if (items != null && items.isNotEmpty) {
      final imgs = items.first['images'] as List<dynamic>?;
      if (imgs != null && imgs.isNotEmpty) {
        image = imgs.first['imageUrl'] ?? '';
      }
      try {
        price = (items.first['sellers'][0]['commertialOffer']['Price'] ?? 0)
            .toDouble();
      } catch (_) {
        price = 0.0;
      }
    }

    return ProductModel(
      id: json['productId'].toString(),
      name: json['productName'] ?? '',
      imageUrl: image,
      price: price,
      description: json['description'] ?? json['metaTagDescription'] ?? '',
      brand: json['brand'] ?? '',
      categories: List<String>.from(json['categories'] ?? []),
      productTitle: json['productTitle'] ?? '',
    );
  }
}
