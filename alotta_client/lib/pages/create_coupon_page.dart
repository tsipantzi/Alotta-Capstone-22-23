import 'dart:developer';

import 'package:alotta_client/assets/data/food_category_type.dart';
import 'package:alotta_client/assets/data/user_restaurant.dart';
import 'package:alotta_client/assets/services/coupon_service.dart';
import 'package:alotta_client/assets/widgets/alotta_app_bar.dart';
import 'package:alotta_client/assets/widgets/error_pop_up.dart';
import 'package:alotta_client/assets/widgets/food_category_bubble.dart';
import 'package:alotta_client/assets/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../assets/data/coupon.dart';
import '../assets/data/restaurant.dart';
import '../main.dart';

class CreateCouponPage extends StatefulWidget {
  final UserRestaurant userRestaurant;
  List<String> selectedCategories = [];
  CreateCouponPage({super.key, required this.userRestaurant});

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
                style: MyApp.platformHeadingStyle.copyWith(fontSize: 20),
                controller: title,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
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
                style: MyApp.platformHeadingStyle.copyWith(fontSize: 20),
                controller: description,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEB7450)),
                  ),
                  labelText: 'Coupon Description',
                ),
              ),
            ),
            Container(
              height: 90,
              padding: const EdgeInsets.fromLTRB(0, 22.5, 0, 22.5),
              width: MediaQuery.of(context).size.width * .95,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: FoodCategoryType.values.map((category) {
                  final categoryBubble = FoodCategoryBubble(
                    category: category.name,
                    onSelected: (MapEntry<String, bool> entry) {
                      if (entry.value) {
                        log('Selected: ${entry.key}');
                        widget.selectedCategories.add(entry.key);
                      } else {
                        log('Deselected: ${entry.key}');
                        widget.selectedCategories.remove(entry.key);
                      }
                    },
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
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                style: MyApp.platformHeadingStyle.copyWith(fontSize: 20),
                controller: discount,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
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
                style: MyApp.platformHeadingStyle.copyWith(fontSize: 20),
                controller: dollarsOff,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
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
                style: MyApp.platformHeadingStyle.copyWith(fontSize: 20),
                controller: totalNumberOfCoupons,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
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
                  style: MyApp.platformHeadingStyle.copyWith(fontSize: 20),
                  controller: startDate,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
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
                style: MyApp.platformHeadingStyle.copyWith(fontSize: 20),
                controller: endDate,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
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
              child: RoundedButton(
                text: "Create Coupon",
                context: context,
                onPressed: () async {
                  String emptyInputBox = getUnfilledInputBox();
                  if (emptyInputBox.isEmpty &&
                      await _createCoupon(widget.userRestaurant.restaurant)) {
                    Navigator.of(context).pushNamed('couponManagerPage',
                        arguments: widget.userRestaurant);
                  } else if (emptyInputBox.isNotEmpty) {
                    showErrorDialog(context, 'Missing Input Field',
                        'The field $emptyInputBox is empty. Please fill it in to create a coupon.');
                  }
                },
              ),
            ),
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
      foodCategories: widget.selectedCategories
          .map((e) => FoodCategoryType.fromString(e))
          .toList(),
      startDate: DateTime.parse(startDate.value.text),
      endDate: DateTime.parse(endDate.value.text),
    );

    log('Creating coupon ${couponToCreate.title} with startDate : ${couponToCreate.startDate} and endDate : ${couponToCreate.endDate}');
    final CouponService service = CouponService();

    return await service.createCoupon(
        couponToCreate, currentRestaurant.id.toString());
  }

  String getUnfilledInputBox() {
    if (title.value.text.isEmpty) {
      return 'Title';
    } else if (description.value.text.isEmpty) {
      return 'Description';
    } else if (widget.selectedCategories.isEmpty) {
      return 'Food Category';
    } else if (discount.value.text.isEmpty) {
      return 'Discount';
    } else if (dollarsOff.value.text.isEmpty) {
      return 'Dollars Off';
    } else if (totalNumberOfCoupons.value.text.isEmpty) {
      return 'Total Number of Coupons';
    } else if (startDate.value.text.isEmpty) {
      return 'Start Date';
    } else if (endDate.value.text.isEmpty) {
      return 'End Date';
    } else {
      return '';
    }
  }
}
