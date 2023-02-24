import 'package:alotta_client/assets/widgets/alotta_app_bar.dart';
import 'package:flutter/material.dart';

import '../assets/colors/colors.dart';
import '../assets/data/app_user.dart';
import '../assets/data/restaurant.dart';

class CouponManagerPage extends StatelessWidget {
  // final AppUser currentUser;
  final Restaurant currentRestaurant;
  const CouponManagerPage({super.key, required this.currentRestaurant});
  static const int pageIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: 250,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/restaurant_placeholder.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(currentRestaurant.name),
            Text(currentRestaurant.phoneNumber),
            Text(currentRestaurant.email),
            Text(currentRestaurant.aboutMe),
            Text("Zip Code: ${currentRestaurant.zipCode}"),
            Text("Categoies: ${currentRestaurant.foodCategories}"),
            Text(
                "Max Catering Size: ${currentRestaurant.maxCateringSizePerPerson}"),
            Text("Minimum Notice: ${currentRestaurant.minimumNotice}"),
            Text(
                "Number of Active Coupons: ${currentRestaurant.numberOfActiveCoupons}"),
                        //Need to add arguments once users is working
                      ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('newCouponPage');
                      },
                      child: const Text('Create Coupon'),
                    ),
          ],
        ),
),
      bottomNavigationBar: AlottaNavigationBar(
        selectedItemColor: primaryOrangeMaterialColor,
        currentUser: const AppUser(),
        context: context,
        currentIndex: CouponManagerPage.pageIndex,
      ),
    );
  }
}
