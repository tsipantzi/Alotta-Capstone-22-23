import 'package:alotta_client/assets/data/app_user.dart';
import 'package:alotta_client/assets/data/coupon_state.dart';
import 'package:alotta_client/assets/data/food_category_type.dart';
import 'package:alotta_client/assets/services/coupon_service.dart';
import 'package:alotta_client/assets/widgets/food_category_bubble.dart';
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

  @override
  State<CouponHomePage> createState() => _CouponHomePageState();

  List<Widget> convertCouponsToCouponCards(List<Coupon> coupons) {
    return currentCoupons
        .map((coupon) => CouponCard(
              coupon: coupon,
              userId: currentUser.id,
              couponState: CouponState.claimable,
            ))
        .toList();
  }

  bool couponContainsSelectedCategory(Coupon coupon) {
    if (selectedCategories.isEmpty) {
      return true;
    }

    return coupon.foodCategories.map((e) => e.name).any((category) =>
        selectedCategories.any((selected) => selected == category));
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
            height: 90,
            width: MediaQuery.of(context).size.width * .95,
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
            padding: const EdgeInsets.fromLTRB(0, 22.5, 0, 22.5),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: FoodCategoryType.values.map((category) {
                final categoryBubble = FoodCategoryBubble(
                  category: category.name,
                  onSelected: (MapEntry<String, bool> entry) => setState(() {
                    if (entry.value) {
                      widget.selectedCategories.add(entry.key);
                    } else {
                      widget.selectedCategories.remove(entry.key);
                    }
                    print(
                        "Updated the list of selected items ${widget.selectedCategories}");
                  }),
                );
                for (var element in widget.selectedCategories) {
                  if (element == category.name) {
                    categoryBubble.isSelected = true;
                  }
                }
                return categoryBubble;
              }).toList(),
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
                              children: widget.convertCouponsToCouponCards(
                                  widget.currentCoupons),
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
        child: const Icon(Icons.shopping_cart),
        onPressed: () => Navigator.of(context)
            .pushNamed('customerInventoryPage', arguments: widget.currentUser),
      ),
      bottomNavigationBar: AlottaNavigationBar(
        currentUser: widget.currentUser,
        context: context,
        selectedIndex: CouponHomePage.pageIndex,
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
        widget.searchTerm,
        widget.currentUser.zipcode
            .substring(0, widget.currentUser.zipcode.length - 2)));
  }

  Future<List<Coupon>> applyFilterToFuture(
      Future<List<Coupon>> futureCoupons) async {
    var coupons = await futureCoupons;
    widget.currentCoupons =
        coupons.where(widget.couponContainsSelectedCategory).toList();
    return widget.currentCoupons;
  }
}
