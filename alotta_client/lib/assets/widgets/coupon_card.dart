import 'dart:async';

import 'package:alotta_client/assets/services/customer_inventory_service.dart';
import 'package:flip_card/flip_card.dart';
import 'package:alotta_client/main.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../colors/colors.dart';
import '../data/app_user.dart';
import '../data/coupon.dart';
import '../data/coupon_state.dart';

class CouponCard extends StatefulWidget {
  final AppUser currentUser;
  final Coupon coupon;
  final Function(Coupon?)? onPressed;
  final CouponState couponState;
  final FlipCardController flipCardController = FlipCardController();

  CouponCard({
    super.key,
    required this.coupon,
    required this.currentUser,
    required this.couponState,
    this.onPressed,
  });

  @override
  State<CouponCard> createState() => _CouponCardState();
}

class _CouponCardState extends State<CouponCard> {
  final Offset _offset = const Offset(0, 0);

  Widget drawButtonByType(BuildContext context) {
    switch (widget.couponState) {
      case CouponState.claimable:
        return TextButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(5),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(Colors.green),
            minimumSize: MaterialStateProperty.all(const Size(150, 35)),
          ),
          onPressed: () => claimCoupon(context),
          child: const Text(
            'Claim Coupon',
            style: TextStyle(
              color: primaryCream,
            ),
          ),
        );

      case CouponState.redeemable:
        return TextButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(5),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            minimumSize: MaterialStateProperty.all(
              const Size(150, 35),
            ),
            backgroundColor: MaterialStateProperty.all(Colors.green),
          ),
          onPressed: () => redeemCoupon(context),
          child: const Text(
            'Redeem Coupon',
            style: TextStyle(
              color: primaryCream,
            ),
          ),
        );

      case CouponState.disabled:
        return const Text("");
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FlipCard(
      front: frontOfCoupon(),
      back: backOfCoupon(),
      direction: FlipDirection.VERTICAL,
      controller: widget.flipCardController,
    );
  }

  void claimCoupon(BuildContext context) async {
    final CustomerInventoryService service = CustomerInventoryService();
    final result = await service.saveCouponForCustomer(
        widget.currentUser.id, widget.coupon.id);
    if (widget.onPressed != null && result != null) {
      await widget.onPressed!(result);
    } else if (widget.onPressed != null) {
      await widget.onPressed!(null);
    }
  }

  void redeemCoupon(BuildContext context) async {
    Navigator.of(context).pushNamed('qrCodePage',
        arguments: [widget.currentUser, widget.coupon.id]);
  }

  Widget frontOfCoupon() {
    return Transform.translate(
      offset: _offset,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
          child: Card(
            elevation: 15,
            borderOnForeground: true,
            color: primaryOrangeMaterialColor.shade900.withOpacity(1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox(
              width: 350,
              height: 200,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: widget.coupon.getImage(200, 200),
                  ),
                  Positioned(
                    top: 50,
                    right: 0,
                    width: 170,
                    child: Text(
                      widget.coupon.title,
                      style: MyApp.platformHeadingStyle
                          .copyWith(color: primaryCream, fontSize: 20),
                      overflow: TextOverflow.visible,
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    right: 0,
                    width: 170,
                    child: Text(
                      'Savings of ${widget.coupon.discount}% or '
                      '\$${widget.coupon.dollarsOff}',
                      style: MyApp.platformHeadingStyle
                          .copyWith(color: primaryCream),
                      overflow: TextOverflow.clip,
                      maxLines: 6,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget backOfCoupon() {
    return Transform.translate(
      offset: _offset,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
          child: Card(
            elevation: 15,
            borderOnForeground: true,
            color: primaryOrangeMaterialColor.shade900.withOpacity(1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox(
              width: 350,
              height: 200,
              child: Stack(
                children: [
                  Positioned(
                    left: 5,
                    top: 5,
                    child: widget.coupon.getImage(150, 150),
                  ),
                  Positioned(
                    left: 5,
                    bottom: 1,
                    child: drawButtonByType(context),
                  ),
                  Positioned(
                    right: 0,
                    top: 25,
                    width: 200,
                    child: Text(
                      style: MyApp.platformHeadingStyle
                          .copyWith(color: primaryCream),
                      "Percentage Off: ${widget.coupon.discount}%",
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 50,
                    width: 200,
                    child: Text(
                      style: MyApp.platformHeadingStyle
                          .copyWith(color: primaryCream),
                      "Dollars Saved: \$${widget.coupon.dollarsOff}",
                      overflow: TextOverflow.clip,
                      maxLines: 6,
                      softWrap: true,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 75,
                    width: 200,
                    child: Text(
                      style: MyApp.platformHeadingStyle
                          .copyWith(color: primaryCream),
                      "Coupons Left: ${widget.coupon.numberOfCouponsLeft}",
                      overflow: TextOverflow.clip,
                      maxLines: 6,
                      softWrap: true,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 100,
                    width: 200,
                    child: Text(
                      style: MyApp.platformHeadingStyle
                          .copyWith(color: primaryCream),
                      "Good Through: ${widget.coupon.startDateShort} - ${widget.coupon.endDateShort}",
                      overflow: TextOverflow.clip,
                      maxLines: 6,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
