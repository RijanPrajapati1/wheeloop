class CarModel {
  final String id;
  final String name;
  final String image;
  final String type;
  final String price;
  final String transmission;
  final String description;

  CarModel({
    required this.id,
    required this.name,
    required this.image,
    required this.type,
    required this.price,
    required this.transmission,
    required this.description,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown',
      image: json['image'] ?? '',
      type: json['type'] ?? 'Unknown',
      price: json['price']?.toString() ?? 'N/A',
      transmission: json['transmission'] ?? 'Unknown',
      description: json['description'] ?? 'No description available',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'type': type,
      'price': price,
      'transmission': transmission,
      'description': description,
    };
  }
}
