import 'package:alotta_client/assets/widgets/alotta_app_bar.dart';
import 'package:alotta_client/assets/widgets/restaurant_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../assets/colors/colors.dart';
import '../assets/data/app_user.dart';
import '../assets/data/restaurant.dart';
import '../assets/services/restaurant_service.dart';

class RestaurantManagerPage extends StatefulWidget {
  final AppUser currentUser;
  const RestaurantManagerPage({super.key, required this.currentUser});
  static const int pageIndex = 1;

  @override
  State<RestaurantManagerPage> createState() => _RestaurantManagerPageState();
}

class _RestaurantManagerPageState extends State<RestaurantManagerPage> {
  @override
  Widget build(BuildContext context) {
    final RestaurantService restaurantService = RestaurantService();

    return FutureBuilder<List<Restaurant>?>(
        future: restaurantService
            .getRestaurantsForUser(widget.currentUser.username),
        builder: (context, AsyncSnapshot<List<Restaurant>?> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AlottaTitle(),
              body: Stack(
                children: [
                  Center(
                    child: ListView(
                      children: snapshot.data!
                          .map(
                            (restaurant) =>
                                RestaurantCard(restaurant: restaurant),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: AlottaNavigationBar(
                selectedItemColor: primaryOrangeMaterialColor,
                currentUser: widget.currentUser,
                context: context,
                currentIndex: RestaurantManagerPage.pageIndex,
              ),
            );
          } else {
            return Scaffold(
              appBar: AlottaTitle(),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
              bottomNavigationBar: AlottaNavigationBar(
                selectedItemColor: primaryOrangeMaterialColor,
                currentUser: widget.currentUser,
                context: context,
                currentIndex: RestaurantManagerPage.pageIndex,
              ),
            );
          }
        });
  }
}
