import 'package:alotta_client/assets/data/user_restaurant.dart';
import 'package:alotta_client/assets/widgets/alotta_app_bar.dart';
import 'package:alotta_client/assets/widgets/restaurant_card.dart';
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
            .getRestaurantsForUserByUserId(widget.currentUser.id),
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
                            (restaurant) => RestaurantCard(
                              userRestaurant: UserRestaurant(
                                  user: widget.currentUser,
                                  restaurant: restaurant),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      style: Theme.of(context).elevatedButtonTheme.style,
                      onPressed: () {
                        Navigator.of(context).pushNamed('newRestaurantPage',
                            arguments: widget.currentUser);
                      },
                      child: const Text('Create Restaurant'),
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
              body: Stack(
                children: [
                  const Text("You currently have no restaurants attached to "
                      "this account. Please add a restaurant."),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('newRestaurantPage',
                            arguments: widget.currentUser);
                      },
                      child: const Text('Create Restaurant'),
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
          }
        });
  }
}
