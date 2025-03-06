class Car {
  final String id;
  final String name;
  final double price;
  final String imageUrl;

  Car({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  // Convert from JSON
  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['_id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}
