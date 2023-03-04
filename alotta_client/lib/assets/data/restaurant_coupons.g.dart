// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_coupons.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantCoupons _$RestaurantCouponsFromJson(Map<String, dynamic> json) =>
    RestaurantCoupons(
      restaurant: json['restaurant'] == null
          ? const Restaurant()
          : Restaurant.fromJson(json['restaurant'] as Map<String, dynamic>),
      coupons: (json['coupons'] as List<dynamic>?)
              ?.map((e) => Coupon.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$RestaurantCouponsToJson(RestaurantCoupons instance) =>
    <String, dynamic>{
      'restaurant': instance.restaurant.toJson(),
      'coupons': instance.coupons.map((e) => e.toJson()).toList(),
    };
