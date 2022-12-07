import 'dart:math';

import 'package:alotta_client/assets/services/coupon_service.dart';
import 'package:flutter/material.dart';

import '../assets/colors/colors.dart';
import '../assets/data/coupon.dart';
import '../assets/widgets/alotta_app_bar.dart';
import '../assets/widgets/coupon_card.dart';
import 'login_page.dart';

class CouponHomePage extends StatefulWidget {
  const CouponHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<CouponHomePage> createState() => _CouponHomePageState();
}

class _CouponHomePageState extends State<CouponHomePage> {
  static const int _pageIndex = 1;

  void _changePage(int index) {
    setState(() {
      switch (index) {
        case 0:
          //Go to LoginPage
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const LoginPage()));
          break;
        case 1:
          //Go to CouponPage
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CouponHomePage()));
          break;
        case 2:
          //Go to SettingsPage
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final CouponService couponService = CouponService();
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return FutureBuilder<List<Coupon>?>(
        future: couponService.getAllCoupons("1"),
        builder: (context, AsyncSnapshot<List<Coupon>?> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AlottaTitle(),
              body: Stack(
                children: [
                  Center(
                    child: ListView(
                      children: snapshot.data!
                          .map(
                            (coupon) => CouponCard(
                              coupon: coupon,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                        shape: const CircleBorder(),
                      ),
                      onPressed: _createCoupon,
                      child: const Text(
                        '+',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: AlottaNavigationBar(
                onTap: _changePage,
                selectedItemColor: primaryGreen,
                currentIndex: _pageIndex,
              ),
            );
          } else {
            return Scaffold(
              appBar: AlottaTitle(),
              body: const Center(
                child: Text(
                    'There was an error or there are currently no coupons available'),
              ),
              bottomNavigationBar: AlottaNavigationBar(
                onTap: _changePage,
                selectedItemColor: primaryGreen,
                currentIndex: _pageIndex,
              ),
            );
          }
        });
  }

  Future<void> _createCoupon() async {
    final CouponService couponService = CouponService();

    final List<Coupon> couponsToCreate = [
      Coupon(
        title: 'Bens Coupon',
        description: 'Lorem ipsum dolor sit amet, consectetur',
        discount: 10.0,
        dollarsOff: 10,
        totalNumberOfCoupons: 10,
        numberOfCouponsSold: 10,
      ),
      Coupon(
        title: 'James Coupon',
        description: 'Lorem ipsum dolor sit amet, consectetur',
        discount: 20.0,
        dollarsOff: 20,
        totalNumberOfCoupons: 20,
        numberOfCouponsSold: 20,
      ),
      Coupon(
        title: 'Deans Coupon',
        description: 'Lorem ipsum dolor sit amet, consectetur',
        discount: 30.0,
        dollarsOff: 30,
        totalNumberOfCoupons: 30,
        numberOfCouponsSold: 30,
      ),
      Coupon(
        title: 'Richard Coupon',
        description: 'Lorem ipsum dolor sit amet, consectetur',
        discount: 40.0,
        dollarsOff: 40,
        totalNumberOfCoupons: 40,
        numberOfCouponsSold: 40,
      ),
    ];

    final result = couponService.createCoupon(
        couponsToCreate[Random().nextInt(couponsToCreate.length)], "1");

    if (await result) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const CouponHomePage()));
    }
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
