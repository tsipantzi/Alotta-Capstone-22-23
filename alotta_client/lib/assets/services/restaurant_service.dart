import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../data/restaurant.dart';
import 'api_constants.dart';

class RestaurantService {
  RestaurantService();

  Future<List<Restaurant>> getRestaurantsForUser(final String username) async {
    try {
      var url = Uri.parse(ApiConstants.restaurantsForUser(username));
      log('Trying to find restaurants by username $username');

      var response = await http.get(url);
      if (response.statusCode == 200) {
        return restuarantsFromJson(response.body);
      }
    } catch (e) {
      log(e.toString());
    }

    return Future.error(
        ErrorDescription("Could not find restaurants for user"));
  }

  List<Restaurant> restuarantsFromJson(String body) {
    log('Got JSON Body $body');
    Iterable restaurantIterable = jsonDecode(body);
    log('Got Iterable $restaurantIterable');
    return List.from(
        restaurantIterable.map((json) => Restaurant.fromJson(json)));
  }

  Future<Restaurant?> updateRestaurant(Restaurant restaurantToUpdate) async {
    try {
      log('Updating the Restaurant for the user is not yet implemented');
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
