// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coupon _$CouponFromJson(Map<String, dynamic> json) {
  return Coupon(
    title: json['title'] as String,
    description: json['couponInfo'] as String,
    discount: (json['percentageOff'] as num).toDouble(),
    dollarsOff: (json['dollarsOff'] as num).toDouble(),
    totalNumberOfCoupons: json['totalNumberOfCoupons'] as int,
    numberOfCouponsSold: json['numberOfCouponsSold'] as int,
  );
}

Map<String, dynamic> _$CouponToJson(Coupon instance) => <String, dynamic>{
      'title': instance.title,
      'couponInfo': instance.description,
      'percentageOff': instance.discount,
      'dollarsOff': instance.dollarsOff,
      'totalNumberOfCoupons': instance.totalNumberOfCoupons,
      'numberOfCouponsSold': instance.numberOfCouponsSold,
    };
