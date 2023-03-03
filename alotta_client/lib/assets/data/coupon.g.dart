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
    );

Map<String, dynamic> _$CouponToJson(Coupon instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'couponInfo': instance.description,
      'percentageOff': instance.discount,
      'dollarsOff': instance.dollarsOff,
      'totalNumberOfCoupons': instance.totalNumberOfCoupons,
      'numberOfCouponsSold': instance.numberOfCouponsSold,
    };
