import 'package:flutter/material.dart';

import '../colors/colors.dart';

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

class AlottaNavigationBar extends BottomNavigationBar {
  static const List<BottomNavigationBarItem> _items = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.logout),
      label: 'Logout',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
  ];
  AlottaNavigationBar({
    super.key,
    required super.onTap,
    required super.selectedItemColor,
    required super.currentIndex,
  }) : super(items: _items);
}
