// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
      userId: json['_id'] as String?,
      full_name: json['full_name'] as String,
      phone_number: json['phone_number'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      password: json['password'] as String,
      confirmPassword: json['confirmPassword'] as String,
    );

Map<String, dynamic> _$AuthApiModelToJson(AuthApiModel instance) =>
    <String, dynamic>{
      '_id': instance.userId,
      'full_name': instance.full_name,
      'phone_number': instance.phone_number,
      'email': instance.email,
      'address': instance.address,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
    };
