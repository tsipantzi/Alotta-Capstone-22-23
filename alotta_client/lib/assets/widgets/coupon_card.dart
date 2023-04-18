import 'package:alotta_client/assets/services/customer_inventory_service.dart';
import 'package:alotta_client/main.dart';
import 'package:flutter/material.dart';

import '../colors/colors.dart';
import '../data/coupon.dart';
import '../data/coupon_state.dart';

class CouponCard extends StatefulWidget {
  final int userId;
  final Coupon coupon;

  final CouponState couponState;

  const CouponCard({
    super.key,
    required this.coupon,
    required this.userId,
    required this.couponState,
  });

  @override
  State<CouponCard> createState() => _CouponCardState();
}

class _CouponCardState extends State<CouponCard> {
  static const BoxShadow _defaultShadow = BoxShadow(
    color: Colors.grey,
    blurRadius: .005,
    spreadRadius: -7,
    offset: Offset(-3, 3),
    blurStyle: BlurStyle.solid,
  );

  static const BoxShadow _pressedDownShadow = BoxShadow(
    color: Colors.grey,
    blurRadius: .05,
    spreadRadius: -8,
    offset: Offset(-1, 1),
    blurStyle: BlurStyle.solid,
  );

  BoxShadow _cardShadow = _defaultShadow;
  Offset _offset = const Offset(0, 0);

  void _pressCardDown() {
    setState(() {
      _cardShadow = _pressedDownShadow;
      _offset = const Offset(-3, 3);
    });
  }

  void _pressCardUp() {
    setState(() {
      _cardShadow = _defaultShadow;
      _offset = const Offset(0, 0);
    });
  }

  void _openCardPopup(final Coupon coupon, final BuildContext context) {
    final String percentageOffText =
        "Percentage Off: ${widget.coupon.discount}%";
    final String dollarsOffText =
        "Dollars Saved: ${widget.coupon.dollarsOff}\$";
    final String numberOfCouponsLeftText =
        "Coupons Left: ${widget.coupon.numberOfCouponsLeft}";
    final String goodThroughText =
        "Good Through: ${widget.coupon.startDateShort} - ${widget.coupon.endDateShort}";
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        children: [
          Container(
            width: 340,
            height: 280,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              color: Colors.transparent,
              image: const DecorationImage(
                image: AssetImage('images/pop_up_background.png'),
              ),
            ),
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Positioned(
                  left: 0,
                  top: 15,
                  child: widget.coupon.getImage(
                      MediaQuery.of(context).size.height * .16,
                      MediaQuery.of(context).size.width * .5),
                ),
                Positioned(
                  right: 15,
                  top: 25,
                  child: Text(
                    coupon.title,
                    textDirection: TextDirection.rtl,
                    style: MyApp.platformBodyStyle,
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 75,
                  width: 150,
                  child: Text(
                    coupon.description,
                    overflow: TextOverflow.clip,
                    maxLines: 3,
                    softWrap: true,
                    style: MyApp.platformBodyStyle,
                  ),
                ),
                drawButtonByType(context),
                Positioned(
                  bottom: 8,
                  right: MediaQuery.of(context).size.width * .15,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style:
                            MyApp.platformHeadingStyle.copyWith(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 80,
                  left: 20,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      percentageOffText,
                      style: MyApp.platformBodyStyle,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 60,
                  left: 20,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      dollarsOffText,
                      style: MyApp.platformBodyStyle,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 60,
                  right: 50,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      numberOfCouponsLeftText,
                      style: MyApp.platformBodyStyle,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 80,
                  right: 15,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      goodThroughText,
                      style: MyApp.platformBodyStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Positioned drawButtonByType(BuildContext context) {
    switch (widget.couponState) {
      case CouponState.claimable:
        return Positioned(
          bottom: 8,
          left: MediaQuery.of(context).size.width * .08,
          child: TextButton(
            onPressed: () => claimCoupon(context),
            child: Center(
              child: Text(
                'Claim Coupon',
                style: MyApp.platformHeadingStyle.copyWith(fontSize: 20),
              ),
            ),
          ),
        );

      case CouponState.redeemable:
        return Positioned(
          bottom: 8,
          left: 40,
          child: TextButton(
            onPressed: () => redeemCoupon(context),
            child: Center(
              child: Text(
                'Redeem Coupon',
                style: MyApp.platformHeadingStyle.copyWith(fontSize: 20),
              ),
            ),
          ),
        );

      case CouponState.disabled:
        return const Positioned(child: Text(""));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Transform.translate(
      offset: _offset,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [_cardShadow],
        ),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
          onTapDown: (TapDownDetails details) => _pressCardDown(),
          onTapUp: (TapUpDetails details) => _pressCardUp(),
          onTapCancel: () => _pressCardUp(),
          onTap: () => _openCardPopup(widget.coupon, context),
          child: Card(
            elevation: 0,
            borderOnForeground: true,
            color: primaryOrangeMaterialColor.shade900.withOpacity(1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.15,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0.0,
                    left: 0.0,
                    child: widget.coupon.getImage(
                        MediaQuery.of(context).size.height * 0.155,
                        MediaQuery.of(context).size.width * 0.45),
                  ),
                  Positioned(
                    top: 0.0,
                    left: 225.0,
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            widget.coupon.title,
                            style: MyApp.platformHeadingStyle,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            widget.coupon.description,
                            style: MyApp.platformBodyStyle,
                            overflow: TextOverflow.clip,
                            maxLines: 6,
                            softWrap: true,
                          ),
                        ),
                      ],
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

  void claimCoupon(BuildContext context) async {
    final CustomerInventoryService service = CustomerInventoryService();
    await service.saveCouponForCustomer(widget.userId, widget.coupon.id);
    Navigator.pop(context);
  }

  void redeemCoupon(BuildContext context) async {
    Navigator.pushNamed(context, 'qrCodePage',
        arguments: [widget.userId, widget.coupon.id]);
  }
}
