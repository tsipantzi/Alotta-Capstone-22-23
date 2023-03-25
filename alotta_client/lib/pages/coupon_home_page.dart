import 'package:alotta_client/assets/data/app_user.dart';
import 'package:alotta_client/assets/services/coupon_service.dart';
import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';

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
  String searchTerm = '';
  List<String> selectedCategories = [];
  final Map<String, bool> categoryMap = {
    "Fast Food": false,
    "Dine-In": false,
    "Carry-Out": false,
    "Mexican": false,
    "Japanese": false,
    "Chinese": false,
    "Italian": false,
    "Mediterranean": false,
    "Subs/Sandwiches": false,
    "Pizza": false,
    "Burgers": false,
    "Dessert": false,
  };

  AppUser getCurrentUser() {
    return currentUser;
  }

  @override
  State<CouponHomePage> createState() => _CouponHomePageState();
}

class _CouponHomePageState extends State<CouponHomePage> {
  void searchForCouponsByTerm(value) async {
    widget.coupons = await widget.couponService
        .getAllCouponsBySearchTerm(value, widget.currentUser.zipcode);
  }

  Widget getAllCoupons() {
    return FutureBuilder<List<Coupon>?>(
        future: widget.couponService.getAllCoupons(widget.currentUser.zipcode),
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
        });
  }

  Widget getAllCouponsBySearchTerm(final String searchTerm) {
    return FutureBuilder<List<Coupon>?>(
        future: widget.couponService
            .getAllCouponsBySearchTerm(searchTerm, widget.currentUser.zipcode),
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
      appBar: AlottaTitle(),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          TextField(
            onChanged: (value) => setState(() => widget.searchTerm = value),
            style: const TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(width: 4.0),
              ),
              hintText: "Search Coupons...",
              prefixIcon: const Icon(Icons.search),
              prefixIconColor: Colors.black,
            ),
          ),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
              padding: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
              child: DropDownMultiSelect(
                hint: const Text("Select food categories..."),
                options: widget.categoryMap.keys.toList(),
                selectedValues: widget.selectedCategories,
                onChanged: (values) {
                  setState(() {
                    widget.selectedCategories = values;
                    values.forEach((value) => {
                          widget.categoryMap[value] =
                              !widget.categoryMap[value]!
                        });
                    widget.coupons =
                        widget.coupons.where((element) => false).toList();
                    print("Updated the map ${widget.categoryMap}");
                  });
                },
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * .68,
            width: MediaQuery.of(context).size.width,
            child: widget.searchTerm == ''
                ? getAllCoupons()
                : getAllCouponsBySearchTerm(widget.searchTerm),
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

  // List<Coupon> filterCoupons(List<Coupon> coupons) {}

  // void flipMapValue(String category) {
  //   categoryMap.entries.forEach((entry) => {
  //     if (entry.key == category) {
  //       entry.value =
  //     }
  //   });
  // }
}
