import 'package:alotta_client/assets/data/app_user.dart';
import 'package:alotta_client/assets/data/restaurant.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_restaurant.g.dart';

@JsonSerializable()
class UserRestaurant {
  final Restaurant restaurant;
  final AppUser appUser;

  const UserRestaurant({
    this.restaurant = const Restaurant(),
    this.appUser = const AppUser(),
  });

  factory UserRestaurant.fromJson(Map<String, dynamic> json) =>
      _$UserRestaurantFromJson(json);

  Map<String, dynamic> toJson() => _$UserRestaurantToJson(this);
}
