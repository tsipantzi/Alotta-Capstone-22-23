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

// class AlottaNavigationBar extends BottomNavigationBar {
//   AppUser currentUser;
//   BuildContext context;

//   static const List<BottomNavigationBarItem> _items = <BottomNavigationBarItem>[
//     BottomNavigationBarItem(
//       icon: Icon(Icons.logout),
//       label: 'Logout',
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(Icons.home),
//       label: 'Home',
//     ),
//     BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
//   ];
//   AlottaNavigationBar({
//     super.key,
//     required super.selectedItemColor,
//     required super.currentIndex,
//     required this.currentUser,
//     required this.context,
//   }) : super(
//           items: _items,
//           onTap: (val) => _changePage(val, context, currentUser),
//         );

//   static _changePage(int index, BuildContext context, AppUser currentUser) {
//     switch (index) {
//       case 0:
//         //Go to LoginPage
//         Navigator.of(context).pushNamed('login');
//         break;
//       case 1:
//         //Go to CouponPage
//         Navigator.of(context).pushNamed('home', arguments: currentUser);
//         break;
//       case 2:
//         //Go to SettingsPage
//         Navigator.of(context).pushNamed('settings', arguments: currentUser);
//         break;
//     }
//   }
// }

class AlottaNavigationBar extends GNav {
  late AppUser currentUser;
  late BuildContext context;

  static const List<GButton> _items = <GButton>[
    GButton(
      icon: Icons.logout,
      text: 'Logout',
    ),
    GButton(
      icon: Icons.home,
      text: 'Home',
    ),
    GButton(icon: Icons.settings, text: 'Settings')
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          tabMargin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          tabs: _items,
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
        //Go to SettingsPage
        Navigator.of(context).pushNamed('settings', arguments: currentUser);
        break;
    }
  }
}
