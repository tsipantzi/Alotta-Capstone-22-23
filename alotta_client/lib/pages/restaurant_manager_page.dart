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
                                  restaurant: restaurant),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    bottom: 10,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        Navigator.of(context).pushNamed('createRestaurantPage',
                            arguments: widget.currentUser);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          color: primaryGreen,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.playlist_add,
                            color: primaryCream,
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: AlottaNavigationBar(
                currentUser: widget.currentUser,
                context: context,
                selectedIndex: RestaurantManagerPage.pageIndex,
              ),
            );
          } else {
            return Scaffold(
              appBar: AlottaTitle(),
              body: Stack(
                children: [
                  const Center(
                    child: Text("You currently have no restaurants attached to "
                        "this account. Please add a restaurant."),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('createRestaurantPage',
                            arguments: widget.currentUser);
                      },
                      child: const Text('Create Restaurant'),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: AlottaNavigationBar(
                currentUser: widget.currentUser,
                context: context,
                selectedIndex: RestaurantManagerPage.pageIndex,
              ),
            );
          }
        });
  }
}
