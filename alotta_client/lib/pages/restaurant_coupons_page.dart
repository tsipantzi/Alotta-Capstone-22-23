import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../assets/colors/colors.dart';
import '../assets/data/coupon.dart';
import '../assets/data/coupon_state.dart';
import '../assets/data/restaurant_coupons.dart';
import '../assets/data/user_restaurant.dart';
import '../assets/services/coupon_service.dart';
import '../assets/widgets/alotta_app_bar.dart';
import '../assets/widgets/coupon_card.dart';
import '../main.dart';

class RestaurantCouponsPage extends StatelessWidget {
  final UserRestaurant userRestaurant;
  final RestaurantCoupons restaurantCoupons;
  final CouponService couponService = CouponService();
  RestaurantCouponsPage({super.key, required this.userRestaurant})
      : restaurantCoupons =
            RestaurantCoupons(restaurant: userRestaurant.restaurant);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AlottaNavigationBar(
        context: context,
        currentUser: userRestaurant.appUser,
        selectedIndex: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Positioned(
              top: 30,
              width: MediaQuery.of(context).size.width * .95,
              height: 200,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryOrangeMaterialColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: primaryOrangeMaterialColor,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              width: MediaQuery.of(context).size.width * .9,
              child: Container(
                height: 200,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                    alignment: Alignment.center,
                    image: AssetImage('images/restaurant_placeholder.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 205,
              width: MediaQuery.of(context).size.width * .95,
              child: Container(
                decoration: BoxDecoration(
                  color: primaryOrangeMaterialColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: primaryOrangeMaterialColor,
                    width: 2,
                  ),
                ),
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Text(
                        restaurantCoupons.restaurant.name,
                        style: MyApp.platformHeadingStyle.copyWith(
                          letterSpacing: 3,
                          color: primaryCream,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        launchUrl(
                          Uri.parse(
                              'tel://${restaurantCoupons.restaurant.phoneNumber}'),
                        );
                      },
                      child: Center(
                        child: Text(
                          restaurantCoupons.restaurant.phoneNumber,
                          style: MyApp.platformBodyStyle.copyWith(
                            decoration: TextDecoration.underline,
                            letterSpacing: 3,
                            color: primaryCream,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        launchUrl(
                          Uri(
                            scheme: 'mailto',
                            path: restaurantCoupons.restaurant.email,
                          ),
                        );
                      },
                      child: Center(
                        child: Text(
                          restaurantCoupons.restaurant.email,
                          style: MyApp.platformBodyStyle.copyWith(
                            color: primaryCream,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Zip Code: ${restaurantCoupons.restaurant.zipCode}",
                      style:
                          MyApp.platformBodyStyle.copyWith(color: primaryCream),
                    ),
                    Text(
                      "Categories: ${restaurantCoupons.restaurant.foodCategories}",
                      style:
                          MyApp.platformBodyStyle.copyWith(color: primaryCream),
                    ),
                    Text(
                      "Max Catering Size: ${restaurantCoupons.restaurant.maxCateringSizePerPerson}",
                      style:
                          MyApp.platformBodyStyle.copyWith(color: primaryCream),
                    ),
                    Text(
                      "Minimum Notice: ${restaurantCoupons.restaurant.minimumNotice}",
                      style:
                          MyApp.platformBodyStyle.copyWith(color: primaryCream),
                    ),
                    Text(
                      "Number of Active Coupons: ${restaurantCoupons.restaurant.numberOfActiveCoupons}",
                      style:
                          MyApp.platformBodyStyle.copyWith(color: primaryCream),
                    ),
                    Text(
                      restaurantCoupons.restaurant.aboutMe,
                      style:
                          MyApp.platformBodyStyle.copyWith(color: primaryCream),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 425,
              width: MediaQuery.of(context).size.width * .95,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .4,
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder<List<Coupon>?>(
                    future: couponService.getAllCouponsByRestaurantId(
                        restaurantCoupons.restaurant.id.toString()),
                    builder: (context, AsyncSnapshot<List<Coupon>?> snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        return Scaffold(
                          body: Stack(
                            children: [
                              Center(
                                child: ListView(
                                  children: snapshot.data!
                                      .map(
                                        (coupon) => CouponCard(
                                          coupon: coupon,
                                          currentUser: userRestaurant.appUser,
                                          couponState: CouponState.claimable,
                                          onPressed: (Coupon? coupon) {
                                            if (coupon != null) {
                                              Navigator.of(context).pushNamed(
                                                'customerInventoryPage',
                                                arguments:
                                                    userRestaurant.appUser,
                                              );
                                            }
                                          },
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Scaffold(
                          body: MyApp.errorDialog(context,
                              'This restaurant currently has no coupons'),
                        );
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
