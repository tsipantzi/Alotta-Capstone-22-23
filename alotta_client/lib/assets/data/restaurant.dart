import 'package:json_annotation/json_annotation.dart';

part 'restaurant.g.dart';

@JsonSerializable()
class Restaurant {
  final double id;
  final String name;
  final String phoneNumber;
  final String aboutMe;
  final String foodCategories;
  final String email;
  final int maxCateringSizePerPerson;
  final int minimumNotice;
  final String zipCode;
  final int numberOfActiveCoupons;

  const Restaurant({
    this.id = 0,
    this.name = '',
    this.phoneNumber = '',
    this.aboutMe = '',
    this.foodCategories = '',
    this.email = '',
    this.maxCateringSizePerPerson = 0,
    this.minimumNotice = 0,
    this.zipCode = '',
    this.numberOfActiveCoupons = 0,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantToJson(this);
}
