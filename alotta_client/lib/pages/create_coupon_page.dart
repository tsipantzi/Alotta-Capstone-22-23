import 'package:alotta_client/assets/data/app_user.dart';
import 'package:alotta_client/assets/widgets/alotta_app_bar.dart';
import 'package:flutter/material.dart';

import '../assets/colors/colors.dart';
import '../assets/data/coupon.dart';
import 'coupon_home_page.dart';

import 'dart:developer';

import '../assets/data/restaurant.dart';
import '../assets/data/user_restaurant.dart';
import '../assets/services/coupon_service.dart';

class CreateCouponPage extends StatefulWidget {
  final Restaurant currentRestaurant;
  const CreateCouponPage({super.key, required this.currentRestaurant});

  @override
  State<CreateCouponPage> createState() => _CreateCouponPage();
}

class _CreateCouponPage extends State<CreateCouponPage> {
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController discount = TextEditingController();
  final TextEditingController dollarsOff = TextEditingController();
  final TextEditingController totalNumberOfCoupons = TextEditingController();
  final TextEditingController startDate = TextEditingController();
  final TextEditingController endDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AlottaTitle(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: title,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEB7450)),
                  ),
                  labelText: 'Coupon Title',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: description,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEB7450)),
                  ),
                  labelText: 'Coupon Description',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: discount,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEB7450)),
                  ),
                  labelText: 'Discount Percent',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: dollarsOff,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEB7450)),
                  ),
                  labelText: 'Dollars Off',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: totalNumberOfCoupons,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEB7450)),
                  ),
                  labelText: 'Number of Coupons',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: startDate,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEB7450)),
                  ),
                  labelText: 'Coupon Starting Date',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: endDate,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEB7450)),
                  ),
                  labelText: 'Coupon Expiration Date',
                ),
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                    onPressed: () async {
                      final Coupon? createdCoupon =
                          await _createCoupon(widget.currentRestaurant);

                      if (createdCoupon != null) {
                        Navigator.of(context).pushNamed('couponManagementPage',
                            arguments: widget.currentRestaurant);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4D9F6B),
                      // ignore: prefer_const_constructors
                      textStyle: TextStyle(fontSize: 20),
                    ),
                    child: const Text('Create Restaurant'))),
          ],
        ),
      ),
    );
  }

  Future<Coupon?> _createCoupon(Restaurant currentRestaurant) async {
    final Coupon couponToCreate = Coupon(
      title: title.value.text,
      description: description.value.text,
      discount: double.parse(discount.value.text),
      dollarsOff: double.parse(dollarsOff.value.text),
      totalNumberOfCoupons: int.parse(totalNumberOfCoupons.value.text),
      startDate: DateTime.parse(startDate.value.text),
      endDate: DateTime.parse(endDate.value.text),
    );

    log('Creating coupon ${couponToCreate.title}');
    final Coupon service = Coupon();

    Coupon couponRequest =
        Coupon(restaurant: couponToCreate, restaurant: currentRestaurant);

    return await service.createCoupon(couponRequest);
  }
}
