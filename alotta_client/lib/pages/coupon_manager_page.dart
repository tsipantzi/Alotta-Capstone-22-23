import 'package:alotta_client/assets/data/restaurant_coupons.dart';
import 'package:alotta_client/assets/data/user_restaurant.dart';
import 'package:flutter/material.dart';

import '../assets/data/coupon.dart';
import '../assets/services/coupon_service.dart';
import '../assets/widgets/coupon_card.dart';

class CouponManagerPage extends StatelessWidget {
  static const int pageIndex = 1;
  final UserRestaurant userRestaurant;
  final RestaurantCoupons restaurantCoupons;
  final CouponService couponService = CouponService();
  CouponManagerPage({super.key, required this.userRestaurant})
      : restaurantCoupons =
            RestaurantCoupons(restaurant: userRestaurant.restaurant);

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
                  Text(
                    restaurantCoupons.restaurant.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(restaurantCoupons.restaurant.phoneNumber),
                  Text(restaurantCoupons.restaurant.email),
                  Text("Zip Code: ${restaurantCoupons.restaurant.zipCode}"),
                  Text(
                      "Categories: ${restaurantCoupons.restaurant.foodCategories}"),
                  Text(
                      "Max Catering Size: ${restaurantCoupons.restaurant.maxCateringSizePerPerson}"),
                  Text(
                      "Minimum Notice: ${restaurantCoupons.restaurant.minimumNotice}"),
                  Text(
                      "Number of Active Coupons: ${restaurantCoupons.restaurant.numberOfActiveCoupons}"),
                  Text(restaurantCoupons.restaurant.aboutMe),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .4,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder<List<Coupon>?>(
                  future: couponService.getAllCoupons(
                      restaurantCoupons.restaurant.id.toString()),
                  builder: (context, AsyncSnapshot<List<Coupon>?> snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
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
                Navigator.of(context)
                    .pushNamed('createCouponPage', arguments: userRestaurant);
              },
              child: const Text('Create Coupon'),
            ),
          ],
        ),
      ),
    );
  }
}
