// import 'package:equatable/equatable.dart';

// class CarEntity extends Equatable {
//   final String? id;
//   final String name;
//   final String type;
//   final String price;
//   final String description;
//   final String transmission;
//   final String image;

//   const CarEntity({
//     this.id,
//     required this.name,
//     required this.type,
//     required this.price,
//     required this.description,
//     required this.transmission,
//     required this.image,
//   });

//   //  Ensure no null values from API
//   factory CarEntity.fromJson(Map<String, dynamic> json) {
//     return CarEntity(
//       id: json["_id"] ?? '',
//       name: json["name"] ?? '',
//       type: json["brand"] ?? '', // Mapping "brand" instead of "type"
//       price: json["price"] ?? '',
//       description: json["description"] ?? '',
//       transmission: json["transmission"] ?? '',
//       image: json["image"] ?? '', // Converts null to empty string
//     );
//   }

//   // Empty Constructor for Initial State
//   const CarEntity.empty()
//       : id = '_empty.id',
//         name = '_empty.name',
//         type = '_empty.type',
//         price = '_empty.price',
//         description = '_empty.description',
//         transmission = '_empty.transmission',
//         image = '_empty.image';

//   @override
//   List<Object?> get props =>
//       [id, name, type, price, description, transmission, image];
// }
