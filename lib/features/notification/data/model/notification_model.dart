import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart'; // This is the generated file

@JsonSerializable()
class NotificationModel {
  final String title;
  final String message;
  final bool isNew;

  NotificationModel(
      {required this.title, required this.message, required this.isNew});

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
