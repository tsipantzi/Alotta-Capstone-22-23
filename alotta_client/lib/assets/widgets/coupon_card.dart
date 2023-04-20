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

  BoxShadow _cardShadow = _defaultShadow;
  Offset _offset = const Offset(0, 0);

  drawButtonByType(BuildContext context) {
    switch (widget.couponState) {
      case CouponState.claimable:
        return TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green)),
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
              backgroundColor: MaterialStateProperty.all(Colors.green)),
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
                height: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    widget.coupon.getImage(100, 200),
                    Column(
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
                height: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    widget.coupon.getImage(100, 200),
                    Column(
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
                        drawButtonByType(context),
                      ],
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
