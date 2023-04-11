import 'dart:developer';

import 'package:alotta_client/assets/data/user_restaurant.dart';
import 'package:alotta_client/assets/services/coupon_service.dart';
import 'package:alotta_client/assets/widgets/alotta_app_bar.dart';
import 'package:alotta_client/assets/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../assets/data/coupon.dart';
import '../assets/data/restaurant.dart';

class CreateCouponPage extends StatefulWidget {
  final UserRestaurant userRestaurant;
  const CreateCouponPage({super.key, required this.userRestaurant});

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
                    icon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFEB7450)),
                    ),
                    labelText: 'Coupon Starting Date',
                  ),
                  readOnly: true,
                  onTap: () async {
                    await _openDatePicker(context, startDate);
                  }),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: endDate,
                decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEB7450)),
                  ),
                  labelText: 'Coupon Expiration Date',
                ),
                readOnly: true,
                onTap: () async {
                  await _openDatePicker(context, endDate);
                },
              ),
            ),
            Container(
                height: 50,
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: RoundedButton(
                  text: "Create Coupon",
                  context: context,
                  onPressed: () async => {
                    if (await _createCoupon(widget.userRestaurant.restaurant)) {
                      Navigator.of(context).pushNamed('couponManagerPage',
                          arguments: widget.userRestaurant);
                    }
                  },
                )),
            Container(
              height: 50,
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: RoundedButton(
                text: "Back",
                context: context,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _openDatePicker(
      BuildContext context, TextEditingController textController) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      log(pickedDate.toIso8601String());
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      log(formattedDate);
      setState(() {
        textController.text =
            formattedDate; //set output date to TextField value.
      });
    } else {}
  }

  Future<bool> _createCoupon(Restaurant currentRestaurant) async {
    final Coupon couponToCreate = Coupon(
      title: title.value.text,
      description: description.value.text,
      discount: double.parse(discount.value.text),
      dollarsOff: double.parse(dollarsOff.value.text),
      totalNumberOfCoupons: int.parse(totalNumberOfCoupons.value.text),
      startDate: DateTime.parse(startDate.value.text),
      endDate: DateTime.parse(endDate.value.text),
    );

    log('Creating coupon ${couponToCreate.title} with startDate : ${couponToCreate.startDate} and endDate : ${couponToCreate.endDate}');
    final CouponService service = CouponService();

    return await service.createCoupon(
        couponToCreate, currentRestaurant.id.toString());
  }
}
