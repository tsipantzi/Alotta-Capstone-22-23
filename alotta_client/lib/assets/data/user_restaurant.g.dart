// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRestaurant _$UserRestaurantFromJson(Map<String, dynamic> json) =>
    UserRestaurant(
      restaurant: json['restaurant'] == null
          ? const Restaurant()
          : Restaurant.fromJson(json['restaurant'] as Map<String, dynamic>),
      appUser: json['appUser'] == null
          ? const AppUser()
          : AppUser.fromJson(json['appUser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserRestaurantToJson(UserRestaurant instance) =>
    <String, dynamic>{
      'restaurant': instance.restaurant.toJson(),
      'appUser': instance.appUser.toJson(),
    };
