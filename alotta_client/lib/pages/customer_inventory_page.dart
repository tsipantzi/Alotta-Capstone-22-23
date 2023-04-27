import 'package:alotta_client/assets/data/coupon_state.dart';
import 'package:alotta_client/assets/services/customer_inventory_service.dart';
import 'package:alotta_client/assets/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

import '../assets/colors/colors.dart';
import '../assets/data/app_user.dart';
import '../assets/data/coupon.dart';
import '../assets/widgets/alotta_app_bar.dart';
import '../assets/widgets/coupon_card.dart';
import '../main.dart';

class CustomerInventoryPage extends StatefulWidget {
  final AppUser currentUser;
  CustomerInventoryPage({super.key, required this.currentUser});
  List<Coupon> currentCoupons = List.empty();
  List<CouponCard> couponCards = List.empty();
  final CustomerInventoryService customerService = CustomerInventoryService();
  //not sure what to make the curent index

  AppUser getCurrentUser() {
    return currentUser;
  }

  @override
  State<CustomerInventoryPage> createState() => _CustomerInventoryPageState();
}

class _CustomerInventoryPageState extends State<CustomerInventoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AlottaTitle(),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * .75,
            width: MediaQuery.of(context).size.width,
            child: Scaffold(
              body: Stack(
                children: [
                  Center(
                    child: FutureBuilder<List<Coupon>?>(
                      future: getCoupons(),
                      builder:
                          (context, AsyncSnapshot<List<Coupon>?> snapshot) {
                        if (snapshot.hasData &&
                            snapshot.data != null &&
                            snapshot.data!.isNotEmpty) {
                          return ListView(
                            children:
                                convertCouponstoCouponCards(snapshot.data!),
                          );
                        } else {
                          return MyApp.errorDialog(
                              context, 'You currently do not have any coupons');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: AlottaNavigationBar(
        context: context,
        currentUser: widget.currentUser,
        selectedIndex: 2,
      ),
    );
  }

  //need to add some functions here?
  Future<List<Coupon>> getCoupons() {
    return widget.customerService
        .getAllClaimedCouponsForCustomer(widget.currentUser.id);
  }

  List<Widget> convertCouponstoCouponCards(List<Coupon> coupons) {
    widget.couponCards = coupons
        .map((coupon) => CouponCard(
              coupon: coupon,
              currentUser: widget.currentUser,
              couponState: CouponState.redeemableAndDeletable,
              deleteCoupon: () {
                widget.customerService
                    .deleteCoupon(widget.currentUser.id, coupon.id);
                Navigator.of(context).pushNamed('customerInventoryPage',
                    arguments: widget.currentUser);
              },
            ))
        .toList();

    return widget.couponCards;
  }
}
