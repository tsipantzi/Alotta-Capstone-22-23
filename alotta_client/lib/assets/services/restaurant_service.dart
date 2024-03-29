import 'dart:convert';
import 'dart:developer';

import 'package:alotta_client/assets/data/user_restaurant.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../data/restaurant.dart';
import 'api_constants.dart';

class RestaurantService {
  RestaurantService();
  static Map<String, String> header = {"Content-Type": "application/json"};

  Future<List<Restaurant>> getRestaurantsForUserByUserId(
      final int userId) async {
    try {
      var url = Uri.parse(ApiConstants.getRestaurantsForUserUrl(userId));
      log('Trying to find restaurants for user');

      var response = await http.get(url);
      if (response.statusCode == 200) {
        return restaurantsFromJson(response.body);
      }
    } catch (e) {
      log(e.toString());
    }

    return Future.error(
        ErrorDescription("Could not find restaurants for user"));
  }

  Future<List<Restaurant>> getRestaurantsForUserByZipcode(
      final String zipCode) async {
    try {
      var url = Uri.parse(ApiConstants.getRestaurantsForZipCode(zipCode));
      log('Trying to find restaurants for user');

      var response = await http.get(url);
      if (response.statusCode == 200) {
        return restaurantsFromJson(response.body);
      }
    } catch (e) {
      log(e.toString());
    }

    return Future.error(
        ErrorDescription("Could not find restaurants for user"));
  }

  Future<UserRestaurant?> createUserRestaurant(
      UserRestaurant userRestaurant) async {
    try {
      var url = Uri.parse(ApiConstants.userRestaurantsUrl());
      log('Attempting to create Restaurant ${userRestaurant.restaurant.name} under '
          'User ${userRestaurant.appUser.username}');

      var response = await http.post(
        url,
        headers: header,
        body: jsonEncode(userRestaurant.toJson()),
      );

      return userRestaurantFromJson(response.body);
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<UserRestaurant?> updateRestaurant(
      UserRestaurant userRestaurant) async {
    try {
      var url = Uri.parse(ApiConstants.userRestaurantsUrl());
      log('Attempting to update Restaurant ${userRestaurant.restaurant} under '
          'User ${userRestaurant.appUser.username}');

      var response = await http.put(
        url,
        headers: header,
        body: jsonEncode(userRestaurant.toJson()),
      );

      return userRestaurantFromJson(response.body);
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<void> deleteRestaurant(final UserRestaurant userRestaurant) async {
    try {
      var url = Uri.parse(ApiConstants.userRestaurantsUrl());
      log('Attempting to delete Restaurant ${userRestaurant.restaurant.id} for user ${userRestaurant.appUser.id}');

      var response = await http.delete(
        url,
        headers: header,
        body: jsonEncode(userRestaurant.toJson()),
      );

      log('Deleted restaurant and received response ${response.body}');
    } catch (e) {
      log(e.toString());
    }
  }

  UserRestaurant userRestaurantFromJson(String body) {
    log('Got JSON Body $body');
    var json = jsonDecode(body);
    return UserRestaurant.fromJson(json);
  }

  List<Restaurant> restaurantsFromJson(String body) {
    log('Got JSON Body $body');
    Iterable restaurantIterable = jsonDecode(body);
    log('Got Iterable $restaurantIterable');
    return List.from(
        restaurantIterable.map((json) => Restaurant.fromJson(json)));
  }
}
