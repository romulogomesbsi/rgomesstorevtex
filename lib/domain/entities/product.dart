class Product {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final String description;
  final String brand;
  final List<String> categories;
  final String productTitle;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    this.description = '',
    this.brand = '',
    this.categories = const [],
    this.productTitle = '',
  });

  String get mainCategory {
    if (categories.isEmpty) return '';
    final category = categories.first;
    final parts = category.split('/').where((s) => s.isNotEmpty).toList();
    return parts.isNotEmpty ? parts.last : '';
  }

  String get displayTitle => productTitle.isNotEmpty ? productTitle : name;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'imageUrl': imageUrl,
        'price': price,
        'description': description,
        'brand': brand,
        'categories': categories,
        'productTitle': productTitle,
      };

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      brand: json['brand'] ?? '',
      categories: List<String>.from(json['categories'] ?? []),
      productTitle: json['productTitle'] ?? '',
    );
  }
}
