import 'package:alotta_client/assets/data/coupon.dart';
import 'package:alotta_client/assets/data/restaurant.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant_coupons.g.dart';

@JsonSerializable()
  class RestaurantCoupons{
    final Restaurant restaurant;
    final List<Coupon> coupons;

    const RestaurantCoupons({
      this.restaurant = const Restaurant(),
      this.coupons = const [],
    });

      factory RestaurantCoupons.fromJson(Map<String, dynamic> json) =>
      _$RestaurantCouponsFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantCouponsToJson(this);
  }
