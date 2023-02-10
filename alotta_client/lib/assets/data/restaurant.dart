import 'package:json_annotation/json_annotation.dart';

part 'restaurant.g.dart';

@JsonSerializable()
class Restaurant {
  final String name;
  final String phoneNumber;
  final String aboutMe;
  final String foodCategories;
  final String email;
  final String maxCateringSizePerPerson;
  final String minimumNotice;
  final String zipCode;

  Restaurant({
    this.name = '',
    this.phoneNumber = '',
    this.aboutMe = '',
    this.foodCategories = '',
    this.email = '',
    this.maxCateringSizePerPerson = '',
    this.minimumNotice = '',
    this.zipCode = '',
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) =>
      _$RestaurantFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantToJson(this);
}
