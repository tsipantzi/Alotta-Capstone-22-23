import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../colors/colors.dart';
import '../data/app_user.dart';

class AlottaTitle extends AppBar {
  AlottaTitle({super.key})
      : super(
          title: Image.asset('images/title.png', fit: BoxFit.fitWidth),
          shadowColor: Colors.transparent,
          backgroundColor: primaryCream,
          toolbarHeight: 110,
          leadingWidth: 0,
        );
}

class AlottaNavigationBar extends GNav {
  late AppUser currentUser;
  late BuildContext context;

  static const List<GButton> _creator_items = <GButton>[
    GButton(
      icon: Icons.logout,
      text: 'Logout',
    ),
    GButton(
      icon: Icons.home,
      text: 'Restaurants',
    ),
    GButton(
      icon: Icons.settings,
      text: 'Settings',
    )
  ];

  static const List<GButton> _consumer_items = <GButton>[
    GButton(
      icon: Icons.logout,
      text: 'Logout',
    ),
    GButton(
      icon: Icons.home,
      text: 'Home',
    ),
    GButton(
      icon: Icons.shopping_cart_checkout,
      text: 'Cart',
    ),
    GButton(
      icon: Icons.settings,
      text: 'Settings',
    ),
    GButton(
      icon: Icons.restaurant,
      text: 'Restaurants',
    ),
  ];

  AlottaNavigationBar({
    super.key,
    required super.selectedIndex,
    required this.currentUser,
    required this.context,
  }) : super(
          backgroundColor: Colors.white,
          tabBackgroundColor: primaryOrangeMaterialColor.shade100,
          activeColor: primaryOrangeMaterialColor,
          curve: Curves.easeOutExpo,
          duration: const Duration(milliseconds: 500),
          gap: 8,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          tabMargin: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
          tabs: currentUser.accountType == AppUserAccountType.CREATOR
              ? _creator_items
              : _consumer_items,
          onTabChange: (val) => _changePage(val, context, currentUser),
        );

  static _changePage(int index, BuildContext context, AppUser currentUser) {
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
        if (currentUser.accountType == AppUserAccountType.CREATOR) {
          //Go to SettingsPage
          Navigator.of(context).pushNamed('settings', arguments: currentUser);
        } else {
          //Go to CartPage
          Navigator.of(context)
              .pushNamed('customerInventoryPage', arguments: currentUser);
        }
        break;
      case 3:
        //Go to SettingsPage
        Navigator.of(context).pushNamed('settings', arguments: currentUser);
        break;
      case 4:
        //Go to RestaurantViewerPage
        Navigator.of(context)
            .pushNamed('restaurantViewerPage', arguments: currentUser);
        break;
    }
  }
}
