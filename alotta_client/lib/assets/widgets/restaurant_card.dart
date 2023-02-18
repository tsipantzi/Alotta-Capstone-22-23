import 'dart:developer';

import 'package:alotta_client/assets/data/restaurant.dart';
import 'package:flutter/material.dart';

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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
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
