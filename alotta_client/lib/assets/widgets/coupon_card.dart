import 'package:alotta_client/assets/services/customer_inventory_service.dart';
import 'package:flip_card/flip_card.dart';
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
            child: Expanded(
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  Positioned(
                    left: -10,
                    top: 25,
                    child: widget.coupon.getImage(110, 220),
                  ),
                  Positioned(
                    right: 15,
                    top: 25,
                    child: Text(
                      coupon.title,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        fontSize: 20,
                        color: primaryCream,
                        shadows: <Shadow>[
                          BoxShadow(
                            color: Colors.black,
                            spreadRadius: 10,
                            blurRadius: 10,
                            blurStyle: BlurStyle.solid,
                          ),
                        ],
                      ),
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
                      style: const TextStyle(
                        color: primaryCream,
                      ),
                    ),
                  ),
                  drawButtonByType(context),
                  Positioned(
                    bottom: 8,
                    right: 75,
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: primaryCream,
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
                        style: const TextStyle(
                          color: primaryCream,
                          shadows: <Shadow>[
                            BoxShadow(
                              color: Colors.black,
                              spreadRadius: 10,
                              blurRadius: 10,
                              blurStyle: BlurStyle.solid,
                            ),
                          ],
                        ),
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
                        style: const TextStyle(
                          color: primaryCream,
                          shadows: <Shadow>[
                            BoxShadow(
                              color: Colors.black,
                              spreadRadius: 10,
                              blurRadius: 10,
                              blurStyle: BlurStyle.solid,
                            ),
                          ],
                        ),
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
                        style: const TextStyle(
                          color: primaryCream,
                          shadows: <Shadow>[
                            BoxShadow(
                              color: Colors.black,
                              spreadRadius: 10,
                              blurRadius: 10,
                              blurStyle: BlurStyle.solid,
                            ),
                          ],
                        ),
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
                        style: const TextStyle(
                          color: primaryCream,
                          shadows: <Shadow>[
                            BoxShadow(
                              color: Colors.black,
                              spreadRadius: 10,
                              blurRadius: 10,
                              blurStyle: BlurStyle.solid,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
          left: 50,
          child: TextButton(
            onPressed: () => claimCoupon(context),
            child: const Text(
              'Claim Coupon',
              style: TextStyle(
                color: primaryCream,
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
            child: const Text(
              'Redeem Coupon',
              style: TextStyle(
                color: primaryCream,
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
    return FlipCard(
      front: Transform.translate(
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
            child: Card(
              elevation: 0,
              borderOnForeground: true,
              color: primaryOrangeMaterialColor.shade900.withOpacity(1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SizedBox(
                width: 350,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    widget.coupon.getImage(100, 200),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: primaryCream,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(-1, -1),
                                    blurRadius: 1,
                                    color: Colors.black12,
                                  ),
                                  Shadow(
                                    offset: Offset(2, 2),
                                    blurRadius: 4,
                                    color: Colors.black12,
                                  )
                                ],
                              ),
                              widget.coupon.title,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              style: const TextStyle(
                                fontSize: 10,
                                color: primaryCream,
                              ),
                              widget.coupon.description,
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
      ),
      back: Transform.translate(
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
            child: Card(
              elevation: 0,
              borderOnForeground: true,
              color: primaryOrangeMaterialColor.shade900.withOpacity(1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SizedBox(
                width: 350,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    widget.coupon.getImage(100, 200),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: primaryCream,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(-1, -1),
                                    blurRadius: 1,
                                    color: Colors.black12,
                                  ),
                                  Shadow(
                                    offset: Offset(2, 2),
                                    blurRadius: 4,
                                    color: Colors.black12,
                                  )
                                ],
                              ),
                              "Percentage Off: ${widget.coupon.discount}%",
                              overflow: TextOverflow.visible,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              style: const TextStyle(
                                fontSize: 10,
                                color: primaryCream,
                              ),
                              "Dollars Saved: \$${widget.coupon.dollarsOff}",
                              overflow: TextOverflow.clip,
                              maxLines: 6,
                              softWrap: true,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              style: const TextStyle(
                                fontSize: 10,
                                color: primaryCream,
                              ),
                              "Coupons Left: ${widget.coupon.numberOfCouponsLeft}",
                              overflow: TextOverflow.clip,
                              maxLines: 6,
                              softWrap: true,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              style: const TextStyle(
                                fontSize: 10,
                                color: primaryCream,
                              ),
                              "Good Through: ${widget.coupon.startDateShort} - ${widget.coupon.endDateShort}",
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
