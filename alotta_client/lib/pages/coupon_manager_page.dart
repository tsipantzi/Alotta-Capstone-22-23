import 'package:alotta_client/assets/data/restaurant_coupons.dart';
import 'package:alotta_client/assets/widgets/alotta_app_bar.dart';
import 'package:flutter/material.dart';

import '../assets/colors/colors.dart';
import '../assets/data/app_user.dart';
import '../assets/data/coupon.dart';
import '../assets/data/restaurant.dart';
import '../assets/services/coupon_service.dart';
import '../assets/widgets/coupon_card.dart';

class CouponManagerPage extends StatelessWidget {
  static const int pageIndex = 1;
  // final AppUser currentUser;
  final Restaurant currentRestaurant;
  final RestaurantCoupons restaurantCoupons;
  final CouponService couponService = CouponService();
  CouponManagerPage({super.key, required this.currentRestaurant})
      : restaurantCoupons = RestaurantCoupons(restaurant: currentRestaurant);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/restaurant_placeholder.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(currentRestaurant.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(currentRestaurant.phoneNumber),
                  Text(currentRestaurant.email),
                  Text("Zip Code: ${currentRestaurant.zipCode}"),
                  Text("Categories: ${currentRestaurant.foodCategories}"),
                  Text(
                      "Max Catering Size: ${currentRestaurant.maxCateringSizePerPerson}"),
                  Text("Minimum Notice: ${currentRestaurant.minimumNotice}"),
                  Text(
                      "Number of Active Coupons: ${currentRestaurant.numberOfActiveCoupons}"),
                  Text(currentRestaurant.aboutMe),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder<List<Coupon>?>(
                  future: couponService
                      .getAllCoupons(currentRestaurant.id.toString()),
                  builder: (context, AsyncSnapshot<List<Coupon>?> snapshot) {
                    if (snapshot.hasData) {
                      return Scaffold(
                        body: Stack(
                          children: [
                            Center(
                              child: ListView(
                                children: snapshot.data!
                                    .map((coupon) => CouponCard(coupon: coupon))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Scaffold(
                        body: Center(
                          child: Text(
                              'There was an error or there are currently no coupons available'),
                        ),
                      );
                    }
                  }),
            ),
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
