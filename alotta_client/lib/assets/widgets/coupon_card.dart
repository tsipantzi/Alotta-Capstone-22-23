import 'package:flutter/material.dart';

import '../colors/colors.dart';
import '../data/coupon.dart';

class CouponCard extends StatefulWidget {
  final Coupon coupon;

  const CouponCard({
    super.key,
    required this.coupon,
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
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              color: Colors.transparent,
              image: const DecorationImage(
                image: AssetImage('images/pop_up_background.png'),
              ),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.coupon.getImage(110, 220),
                  Text(coupon.title,
                    textDirection: TextDirection.rtl,),
                  Text(coupon.description),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Claim Coupon'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ]),
          ),
        ],
      ),
    );
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
              width: 350,
              height: 100,
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
                          overflow: TextOverflow.visible,
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
    );
  }
}
