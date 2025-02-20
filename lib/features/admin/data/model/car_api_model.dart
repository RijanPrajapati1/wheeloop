import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wheeloop/features/admin/domain/entity/car_entity.dart';

part 'car_api_model.g.dart';

@JsonSerializable()
class CarApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String name;
  final String type;
  final String price;
  final String description;
  final String transmission;
  final String image;

  const CarApiModel({
    this.id,
    required this.name,
    required this.type,
    required this.price,
    required this.description,
    required this.transmission,
    required this.image,
  });

  // From JSON
  factory CarApiModel.fromJson(Map<String, dynamic> json) =>
      _$CarApiModelFromJson(json);

  // To JSON
  Map<String, dynamic> toJson() => _$CarApiModelToJson(this);

  // From Entity
  factory CarApiModel.fromEntity(CarEntity entity) {
    return CarApiModel(
      id: entity.id,
      name: entity.name,
      type: entity.type,
      price: entity.price,
      description: entity.description,
      transmission: entity.transmission,
      image: entity.image,
    );
  }

  // To Entity
  CarEntity toEntity() {
    return CarEntity(
      id: id,
      name: name,
      type: type,
      price: price,
      description: description,
      transmission: transmission,
      image: image,
    );
  }

  @override
  List<Object?> get props =>
      [id, name, type, price, description, transmission, image];
}
