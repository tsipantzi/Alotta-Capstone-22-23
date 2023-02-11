import 'package:alotta_client/assets/widgets/alotta_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../assets/colors/colors.dart';
import '../assets/data/app_user.dart';
import '../assets/data/restaurant.dart';
import '../assets/services/restaurant_service.dart';

class RestaurantManagerPage extends StatefulWidget {
  final AppUser currentUser;
  const RestaurantManagerPage({super.key, required this.currentUser});

  @override
  State<RestaurantManagerPage> createState() => _RestaurantManagerPageState();
}

class _RestaurantManagerPageState extends State<RestaurantManagerPage> {
  static const int _pageIndex = 1;

  void _changePage(int index, AppUser currentUser) {
    setState(() {
      switch (index) {
        case 0:
          //Go to LoginPage
          Navigator.of(context).pushNamed('login');
          break;
        case 1:
          //Go to CouponPage
          Navigator.of(context).pushNamed('home', arguments: currentUser);
          break;
        case 2:
          //Go to SettingsPage
          Navigator.of(context).pushNamed('settings', arguments: currentUser);
          break;
      }
    });
  }

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
                                Text('Found this restaurant $restaurant'),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: AlottaNavigationBar(
                onTap: (val) => _changePage(val, widget.currentUser),
                selectedItemColor: primaryGreen,
                currentIndex: _pageIndex,
              ),
            );
          } else {
            return Scaffold(
              appBar: AlottaTitle(),
              body: const Center(
                child: Text(
                    'There was an error or there are currently no restaurants available'),
              ),
              bottomNavigationBar: AlottaNavigationBar(
                onTap: (val) => _changePage(val, widget.currentUser),
                selectedItemColor: primaryGreen,
                currentIndex: _pageIndex,
              ),
            );
          }
        });
  }
}
