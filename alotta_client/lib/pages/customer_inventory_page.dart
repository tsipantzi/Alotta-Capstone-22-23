import 'package:alotta_client/assets/services/customer_inventory_service.dart';
import 'package:flutter/material.dart';

import '../assets/colors/colors.dart';
import '../assets/data/app_user.dart';
import '../assets/data/coupon.dart';
import '../assets/widgets/alotta_app_bar.dart';
import '../assets/widgets/coupon_card.dart';

class CustomerInventoryPage extends StatefulWidget {
  final AppUser currentUser;
  CustomerInventoryPage({super.key, required this.currentUser});
  List<Coupon> currentCoupons = List.empty();
  List<CouponCard> couponCards = List.empty();
  final CustomerInventoryService customerService = CustomerInventoryService();
  bool reloadAllCoupons = true;
  //not sure what to make the curent index
  static const pageIndex = 2;

  AppUser getCurrentUser() {
    return currentUser;
  }

  @override
  State<CustomerInventoryPage> createState() => _CustomerInventoryPageState();

  //not sure if I need the where statement or what goes in there for me
  List<Widget> convertCouponstoCouponCards(List<Coupon> coupons) {
    couponCards = coupons
        .where()
        .map((coupon) => couponCard(coupon: coupon, userId: currentUser.id))
        .toList();

    updateGlobalCoupons(coupons);
    return couponCards;
  }

  // void updateGlobalCoupons(List<Coupon> coupons) {
  //   currentCoupons = coupons.where()
  // }
}

class _CustomerInventoryPageState extends State<CustomerInventoryPage> {
  @override
  void initState() {
    super.initState();
    widget.reloadAllCoupons = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AlottaTitle(),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
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
      bottomNavigationBar: AlottaNavigationBar(
        selectedItemColor: primaryOrangeMaterialColor,
        currentUser: widget.currentUser,
        context: context,
        currentIndex: CustomerInventoryPage.pageIndex,
      ),
    );
  }

  //need to add some functions here?
  Future<List<Coupon>> getCoupons() {
    return widget.customerService
        .getAllClaimedCouponsForCustomer(widget.currentUser.id);
  }
}
