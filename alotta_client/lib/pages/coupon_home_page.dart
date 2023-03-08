import 'dart:math';

import 'package:alotta_client/assets/data/app_user.dart';
import 'package:alotta_client/assets/services/coupon_service.dart';
import 'package:flutter/material.dart';

import '../assets/colors/colors.dart';
import '../assets/data/coupon.dart';
import '../assets/widgets/alotta_app_bar.dart';
import '../assets/widgets/coupon_card.dart';

class CouponHomePage extends StatefulWidget {
  final AppUser currentUser;
  CouponHomePage({super.key, required this.currentUser});
  static const pageIndex = 1;
  List<Coupon> coupons = List.empty();
  final CouponService couponService = CouponService();

  AppUser getCurrentUser() {
    return currentUser;
  }

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
  void searchForCouponsByTerm(value) {
    widget.coupons = widget.couponService.getAllCouponsBySearchTerm(value);
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
      appBar: AlottaTitle(),
      body: ListView(
        children: <Widget>[
          TextField(
            onChanged: (value) => setState(() => searchForCouponsByTerm(value)),
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide.none,
              ),
              hintText: "Search Coupons...",
              prefixIcon: Icon(Icons.search),
              prefixIconColor: Colors.black,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .4,
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder<List<Coupon>?>(
                future: widget.couponService.getAllCoupons("1"),
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
        ],
      ),
      bottomNavigationBar: AlottaNavigationBar(
        selectedItemColor: primaryOrangeMaterialColor,
        currentUser: widget.currentUser,
        context: context,
        currentIndex: CouponHomePage.pageIndex,
      ),
    );
  }
}
