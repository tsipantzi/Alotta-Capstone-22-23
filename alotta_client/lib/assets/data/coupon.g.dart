// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coupon _$CouponFromJson(Map<String, dynamic> json) => Coupon(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      description: json['couponInfo'] as String? ?? '',
      discount: (json['percentageOff'] as num?)?.toDouble() ?? 0,
      dollarsOff: (json['dollarsOff'] as num?)?.toDouble() ?? 0,
      totalNumberOfCoupons: json['totalNumberOfCoupons'] as int? ?? 0,
      numberOfCouponsSold: json['numberOfCouponsSold'] as int? ?? 0,
      foodCategories:
          Coupon._fromJsonCategories(json['foodCategories'] as String),
      startDate: Coupon._fromJson(json['startDate'] as String),
      endDate: Coupon._fromJson(json['endDate'] as String),
    );

Map<String, dynamic> _$CouponToJson(Coupon instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'couponInfo': instance.description,
      'foodCategories': Coupon._toJsonCategories(instance.foodCategories),
      'percentageOff': instance.discount,
      'dollarsOff': instance.dollarsOff,
      'totalNumberOfCoupons': instance.totalNumberOfCoupons,
      'numberOfCouponsSold': instance.numberOfCouponsSold,
      'startDate': Coupon._toJson(instance.startDate),
      'endDate': Coupon._toJson(instance.endDate),
    };
