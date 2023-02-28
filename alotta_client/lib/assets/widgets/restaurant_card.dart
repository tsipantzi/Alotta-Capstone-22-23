import 'dart:developer';

import 'package:alotta_client/assets/data/restaurant.dart';
import 'package:flutter/material.dart';

import '../colors/colors.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCard({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            log("Was tapped");
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Align(
                          alignment: const Alignment(.9, -.7),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(
                                      215, 84, 47, 0.9019607843137255),
                                  spreadRadius: 2,
                                  blurRadius: 1,
                                  offset: Offset(0, 0),
                                  blurStyle: BlurStyle.inner,
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    'editRestaurantPage',
                                    arguments: restaurant);
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
                      ),
                      Flexible(
                        flex: 0,
                        child: Text(
                          style: Theme.of(context).primaryTextTheme.bodyText1,
                          restaurant.name,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          style: Theme.of(context).primaryTextTheme.bodyText1,
                          restaurant.zipCode,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          style: Theme.of(context).primaryTextTheme.bodyText1,
                          restaurant.email,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          style: Theme.of(context).primaryTextTheme.bodyText1,
                          "Active coupons: ${restaurant.numberOfActiveCoupons}",
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
}
