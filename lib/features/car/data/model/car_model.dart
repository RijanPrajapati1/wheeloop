import 'package:json_annotation/json_annotation.dart';
import 'package:wheeloop/features/car/domain/entity/car_entity.dart';

part 'car_model.g.dart';

@JsonSerializable()
class CarModel extends Car {
  CarModel({
    required super.id,
    required super.name,
    required super.price,
    required super.imageUrl,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) =>
      _$CarModelFromJson(json);
  Map<String, dynamic> toJson() => _$CarModelToJson(this);
}
