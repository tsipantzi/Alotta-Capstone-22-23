import 'package:alotta_client/assets/data/app_user.dart';
import 'package:alotta_client/assets/data/coupon_state.dart';
import 'package:alotta_client/assets/data/food_category_type.dart';
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
  List<Coupon> currentCoupons = List.empty();
  List<CouponCard> couponCards = List.empty();
  final CouponService couponService = CouponService();
  String searchTerm = '';
  List<String> selectedCategories = [];
  List<String> categoriesAvailable =
      FoodCategoryType.values.map((e) => e.name).toList();

  AppUser getCurrentUser() {
    return currentUser;
  }

  @override
  State<CouponHomePage> createState() => _CouponHomePageState();

  List<Widget> convertCouponsToCouponCards(List<Coupon> coupons) {
    couponCards = coupons
        .where(couponContainsSelectedCategory)
        .map((coupon) => CouponCard(
              coupon: coupon,
              userId: currentUser.id,
              couponState: CouponState.claimable,
            ))
        .toList();

    updateGlobalCoupons(coupons);
    return couponCards;
  }

  void updateGlobalCoupons(List<Coupon> coupons) {
    currentCoupons = coupons.where(couponContainsSelectedCategory).toList();
  }

  void applyFilterToCurrentCoupons() {
    if (selectedCategories.isEmpty) return;
    if (currentCoupons.isEmpty) return;
    currentCoupons =
        currentCoupons.where(couponContainsSelectedCategory).toList();
  }

  bool couponContainsSelectedCategory(Coupon coupon) {
    if (selectedCategories.isEmpty) {
      return true;
    }

    return coupon.foodCategoriesStrings
        .firstWhere((category) => selectedCategories.contains(category))
        .isNotEmpty;
  }
}

class _CouponHomePageState extends State<CouponHomePage> {
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
              decoration: null,
              hint: const Text("Select food categories..."),
              options: widget.categoriesAvailable,
              selectedValues: widget.selectedCategories,
              onChanged: (values) {
                setState(() {
                  widget.selectedCategories = values;
                  widget.applyFilterToCurrentCoupons();
                  print(
                      "Updated the list of selected items ${widget.selectedCategories}");
                });
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .68,
            width: MediaQuery.of(context).size.width,
            child: Scaffold(
              body: Stack(
                children: [
                  Center(
                    child: FutureBuilder<List<Coupon>?>(
                        future: getCoupons(),
                        builder:
                            (context, AsyncSnapshot<List<Coupon>?> snapshot) {
                          if (snapshot.hasData && snapshot.data != null) {
                            return ListView(
                              children: widget
                                  .convertCouponsToCouponCards(snapshot.data!),
                            );
                          } else {
                            return const Center(
                              child: Text(
                                  'There was an error or there are currently no coupons available'),
                            );
                          }
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryGreen,
        child: Icon(Icons.shopping_cart),
        onPressed: () => Navigator.of(context)
            .pushNamed('customerInventoryPage', arguments: widget.currentUser),
      ),
      bottomNavigationBar: AlottaNavigationBar(
        selectedItemColor: primaryOrangeMaterialColor,
        currentUser: widget.currentUser,
        context: context,
        currentIndex: CouponHomePage.pageIndex,
      ),
    );
  }

  Future<List<Coupon>> getCoupons() async {
    if (widget.searchTerm == '') {
      return applyFilterToFuture(widget.couponService.getAllCoupons(widget
          .currentUser.zipcode
          .substring(0, widget.currentUser.zipcode.length - 2)));
    }

    return applyFilterToFuture(widget.couponService.getAllCouponsBySearchTerm(
        widget.searchTerm, widget.currentUser.zipcode));
  }

  Future<List<Coupon>> applyFilterAndCastToFuture(List<Coupon> coupons) async {
    return coupons.where(widget.couponContainsSelectedCategory).toList();
  }

  Future<List<Coupon>> applyFilterToFuture(
      Future<List<Coupon>> futureCoupons) async {
    var coupons = await futureCoupons;
    return coupons.where(widget.couponContainsSelectedCategory).toList();
  }
}
