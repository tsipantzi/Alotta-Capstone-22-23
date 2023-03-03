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
      user: json['user'] == null
          ? const AppUser()
          : AppUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserRestaurantToJson(UserRestaurant instance) =>
    <String, dynamic>{
      'restaurant': instance.restaurant.toJson(),
      'user': instance.user.toJson(),
    };
