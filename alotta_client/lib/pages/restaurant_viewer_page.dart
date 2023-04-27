import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../assets/colors/colors.dart';
import '../assets/data/app_user.dart';
import '../assets/data/restaurant.dart';
import '../assets/data/user_restaurant.dart';
import '../assets/services/restaurant_service.dart';
import '../assets/widgets/alotta_app_bar.dart';
import '../assets/widgets/restaurant_card.dart';

class RestaurantViewerPage extends StatefulWidget {
  final AppUser currentUser;
  final RestaurantService restaurantService = RestaurantService();
  RestaurantViewerPage({super.key, required this.currentUser});
  static const int pageIndex = 4;

  @override
  State<RestaurantViewerPage> createState() => _RestaurantManagerPageState();
}

class _RestaurantManagerPageState extends State<RestaurantViewerPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Restaurant>?>(
        future: widget.restaurantService
            .getRestaurantsForUserByZipcode(widget.currentUser.zipcode),
        builder: (context, AsyncSnapshot<List<Restaurant>?> snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return Scaffold(
              appBar: AlottaTitle(),
              body: Stack(
                children: [
                  Center(
                    child: ListView(
                      children: snapshot.data!
                          .map(
                            (restaurant) => RestaurantCard(
                              userRestaurant: UserRestaurant(
                                appUser: widget.currentUser,
                                restaurant: restaurant,
                              ),
                              canEdit: false,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: AlottaNavigationBar(
                currentUser: widget.currentUser,
                context: context,
                selectedIndex: RestaurantViewerPage.pageIndex,
              ),
            );
          } else {
            return Scaffold(
              appBar: AlottaTitle(),
              body: Stack(
                children: const [
                  Center(
                    child: Text(
                        "There are currently no Restaurants listed in your area."),
                  ),
                ],
              ),
              bottomNavigationBar: AlottaNavigationBar(
                currentUser: widget.currentUser,
                context: context,
                selectedIndex: RestaurantViewerPage.pageIndex,
              ),
            );
          }
        });
  }
}
