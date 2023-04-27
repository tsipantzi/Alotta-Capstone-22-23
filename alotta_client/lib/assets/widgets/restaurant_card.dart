import 'package:alotta_client/assets/data/user_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';
import '../colors/colors.dart';

class RestaurantCard extends StatelessWidget {
  final UserRestaurant userRestaurant;
  bool canEdit;

  RestaurantCard({
    super.key,
    required this.userRestaurant,
    this.canEdit = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            canEdit
                ? Navigator.of(context)
                    .pushNamed('couponManagerPage', arguments: userRestaurant)
                : Navigator.of(context).pushNamed('restaurantCouponsPage',
                    arguments: userRestaurant);
          },
          child: SizedBox(
            height: 250,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildSettingsButton(context)!,
                      Flexible(
                        flex: 0,
                        child: Text(
                          style: MyApp.platformHeadingStyle
                              .copyWith(color: primaryCream, fontSize: 20),
                          userRestaurant.restaurant.name,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            launchUrl(
                              Uri(
                                scheme: 'tel',
                                path: userRestaurant.restaurant.phoneNumber,
                              ),
                            );
                          },
                          child: Text(
                            style: MyApp.platformBodyStyle.copyWith(
                              color: primaryCream,
                              decoration: TextDecoration.underline,
                            ),
                            userRestaurant.restaurant.phoneNumber,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            launchUrl(
                              Uri(
                                scheme: 'mailto',
                                path: userRestaurant.restaurant.email,
                              ),
                            );
                          },
                          child: Text(
                            style: MyApp.platformBodyStyle.copyWith(
                              color: primaryCream,
                              decoration: TextDecoration.underline,
                            ),
                            userRestaurant.restaurant.email,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          style: MyApp.platformBodyStyle
                              .copyWith(color: primaryCream),
                          "Active coupons: ${userRestaurant.restaurant.numberOfActiveCoupons}",
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSettingsButton(BuildContext context) {
    if (canEdit) {
      return Flexible(
        flex: 0,
        child: Align(
          alignment: const Alignment(.9, -.7),
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(215, 84, 47, 0.9019607843137255),
                  spreadRadius: 2,
                  blurRadius: 1,
                  offset: Offset(0, 0),
                  blurStyle: BlurStyle.inner,
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed('editRestaurantPage', arguments: userRestaurant);
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(5.0),
                backgroundColor: primaryCream,
              ),
              child: const Icon(
                Icons.settings,
                color: primaryOrangeMaterialColor,
                size: 32.0,
              ),
            ),
          ),
        ),
      );
    }
    return Container();
  }
}
