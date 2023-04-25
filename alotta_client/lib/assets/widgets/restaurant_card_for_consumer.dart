import 'package:alotta_client/assets/data/restaurant.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../colors/colors.dart';
import '../data/user_restaurant.dart';

class RestaurantCardForConsumer extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCardForConsumer({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Flexible(
            child: Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 5, 0),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            image: DecorationImage(
              image: AssetImage('images/restaurant_placeholder.png'),
            ),
          ),
        )),
        Text(
          "Zip Code: ${restaurant.zipCode}",
          style: MyApp.platformBodyStyle.copyWith(color: primaryCream),
        ),
        Text(
          "Categories: ${restaurant.foodCategories}",
          style: MyApp.platformBodyStyle.copyWith(color: primaryCream),
        ),
        Text(
          "Max Catering Size: ${restaurant.maxCateringSizePerPerson}",
          style: MyApp.platformBodyStyle.copyWith(color: primaryCream),
        ),
        Text(
          "Minimum Notice: ${restaurant.minimumNotice}",
          style: MyApp.platformBodyStyle.copyWith(color: primaryCream),
        ),
        Text(
          "Number of Active Coupons: ${restaurant.numberOfActiveCoupons}",
          style: MyApp.platformBodyStyle.copyWith(color: primaryCream),
        ),
        Text(
          restaurant.aboutMe,
          style: MyApp.platformBodyStyle.copyWith(color: primaryCream),
        ),
      ],
    );
  }
}
