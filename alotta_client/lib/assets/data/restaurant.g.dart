// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Restaurant _$RestaurantFromJson(Map<String, dynamic> json) => Restaurant(
      name: json['name'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      aboutMe: json['aboutMe'] as String? ?? '',
      foodCategories: json['foodCategories'] as String? ?? '',
      email: json['email'] as String? ?? '',
      maxCateringSizePerPerson:
          json['maxCateringSizePerPerson'] as String? ?? '',
      minimumNotice: json['minimumNotice'] as String? ?? '',
      zipCode: json['zipCode'] as String? ?? '',
    );

Map<String, dynamic> _$RestaurantToJson(Restaurant instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'aboutMe': instance.aboutMe,
      'foodCategories': instance.foodCategories,
      'email': instance.email,
      'maxCateringSizePerPerson': instance.maxCateringSizePerPerson,
      'minimumNotice': instance.minimumNotice,
      'zipCode': instance.zipCode,
    };