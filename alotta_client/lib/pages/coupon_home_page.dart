import 'package:flutter/material.dart';

import '../assets/colors/colors.dart';
import '../assets/data/coupon.dart';
import '../assets/widgets/alotta_app_bar.dart';
import '../assets/widgets/coupon_card.dart';

class CouponHomePage extends StatefulWidget {
  const CouponHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<CouponHomePage> createState() => _CouponHomePageState();
}

class _CouponHomePageState extends State<CouponHomePage> {
  static const int _pageIndex = 1;

  static final _coupons = <Coupon>[
    Coupon(
      title: 'Placeholder title 1',
      description: 'Placeholder description 2',
      image: Image.network(
          'https://dash-bootstrap-components.opensource.faculty.ai/static/images/placeholder286x180.png'),
    ),
    Coupon(
      title: 'Placeholder title 2',
      description: 'Placeholder description 2',
      image: Image.network(
          'https://dash-bootstrap-components.opensource.faculty.ai/static/images/placeholder286x180.png'),
    ),
    Coupon(
      title: 'Placeholder title 2',
      description: 'Placeholder description 2',
      image: Image.network(
          'https://dash-bootstrap-components.opensource.faculty.ai/static/images/placeholder286x180.png'),
    ),
    Coupon(
      title: 'Placeholder title 2',
      description: 'Placeholder description 2',
      image: Image.network(
          'https://dash-bootstrap-components.opensource.faculty.ai/static/images/placeholder286x180.png'),
    ),
    Coupon(
      title: 'Placeholder title 2',
      description: 'Placeholder description 2',
      image: Image.network(
          'https://dash-bootstrap-components.opensource.faculty.ai/static/images/placeholder286x180.png'),
    ),
    Coupon(
      title: 'Placeholder title 2',
      description: 'Placeholder description 2',
      image: Image.network(
          'https://dash-bootstrap-components.opensource.faculty.ai/static/images/placeholder286x180.png'),
    ),
  ];

  static final _couponCards =
  _coupons.map((e) => CouponCard(coupon: e)).toList();

  void _changePage(int index) {
    setState(() {
      switch (index) {
        case 0:
        //Go to LoginPage
          break;
        case 1:
        //Go to CouponPage
          break;
        case 2:
        //Go to SettingsPage
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AlottaAppBar(),
      body: Center(
        child: ListView(
          children: _couponCards,
        ),
      ),
      bottomNavigationBar: AlottaNavigationBar(
        onTap: _changePage,
        selectedItemColor: primaryGreen,
        currentIndex: _pageIndex,
      ),
    );
  }
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