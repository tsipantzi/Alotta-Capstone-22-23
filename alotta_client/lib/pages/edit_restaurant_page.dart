import 'dart:developer';

import 'package:alotta_client/assets/data/user_restaurant.dart';
import 'package:alotta_client/assets/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../assets/data/restaurant.dart';
import '../assets/services/restaurant_service.dart';
import '../assets/widgets/alotta_app_bar.dart';
import '../main.dart';

class EditRestaurantPage extends StatefulWidget {
  final UserRestaurant userRestaurant;
  const EditRestaurantPage({super.key, required this.userRestaurant});

  @override
  State<EditRestaurantPage> createState() => _EditRestaurantPage();
}

class _EditRestaurantPage extends State<EditRestaurantPage> {
  TextEditingController restaurantName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController aboutMe = TextEditingController();
  TextEditingController foodCategories = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController maxCateringSizePerPerson = TextEditingController();
  TextEditingController minimumDayNoticeForCatering = TextEditingController();
  TextEditingController zipCode = TextEditingController();

  @override
  void initState() {
    super.initState();
    restaurantName.text = widget.userRestaurant.restaurant.name;
    phoneNumber.text = widget.userRestaurant.restaurant.phoneNumber;
    aboutMe.text = widget.userRestaurant.restaurant.aboutMe;
    foodCategories.text = widget.userRestaurant.restaurant.foodCategories;
    email.text = widget.userRestaurant.restaurant.email;
    maxCateringSizePerPerson.text =
        widget.userRestaurant.restaurant.maxCateringSizePerPerson.toString();
    minimumDayNoticeForCatering.text =
        widget.userRestaurant.restaurant.minimumNotice.toString();
    zipCode.text = widget.userRestaurant.restaurant.zipCode;
  }

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
              child: MyApp.platformTextField(
                hintText: 'Restaurant Name',
                controller: restaurantName,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: MyApp.platformTextField(
                hintText: 'Phone Number',
                controller: phoneNumber,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: MyApp.platformTextField(
                hintText: 'About Me',
                controller: aboutMe,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: MyApp.platformTextField(
                hintText: 'Food Categories',
                controller: foodCategories,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: MyApp.platformTextField(
                hintText: 'Email',
                controller: email,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: MyApp.platformTextField(
                hintText: 'Max Catering Size Per Person',
                controller: maxCateringSizePerPerson,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: MyApp.platformTextField(
                hintText: 'Minimum Day Notice For Catering',
                controller: minimumDayNoticeForCatering,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: MyApp.platformTextField(
                hintText: 'ZipCode',
                controller: zipCode,
              ),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: RoundedButton(
                onPressed: () async {
                  final UserRestaurant? updatedUserRestaurant =
                      await _updateRestaurant(widget.userRestaurant);

                  if (updatedUserRestaurant != null) {
                    Navigator.of(context).pushNamed('home',
                        arguments: widget.userRestaurant.appUser);
                  }
                },
                text: 'Update Restaurant',
                context: context,
              ),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: RoundedButton(
                text: 'Back',
                context: context,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<UserRestaurant?> _updateRestaurant(
      UserRestaurant userRestaurant) async {
    final Restaurant restaurantToUpdate = Restaurant(
      id: userRestaurant.restaurant.id,
      name: restaurantName.value.text,
      phoneNumber: phoneNumber.value.text,
      aboutMe: aboutMe.value.text,
      foodCategories: foodCategories.value.text,
      email: email.value.text,
      maxCateringSizePerPerson: int.parse(maxCateringSizePerPerson.value.text),
      minimumNotice: int.parse(minimumDayNoticeForCatering.value.text),
      zipCode: zipCode.value.text,
    );

    log('Updating restaurant ${restaurantToUpdate.name}');
    final RestaurantService service = RestaurantService();

    UserRestaurant userRestaurantRequest = UserRestaurant(
        restaurant: restaurantToUpdate, appUser: userRestaurant.appUser);

    return await service.updateRestaurant(userRestaurantRequest);
  }
}
