class Order {
  final String id;
  final List<Map<String, dynamic>> items;
  final double total;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.items,
    required this.total,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'items': items,
    'total': total,
    'createdAt': createdAt.toIso8601String(),
  };

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      items: List<Map<String, dynamic>>.from(json['items'] ?? []),
      total: (json['total'] ?? 0).toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
