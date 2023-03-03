import 'dart:developer';

import 'package:alotta_client/assets/data/user_restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../assets/data/restaurant.dart';
import '../assets/services/restaurant_service.dart';
import '../assets/widgets/alotta_app_bar.dart';

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
              child: TextField(
                controller: restaurantName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEB7450)),
                  ),
                  labelText: 'Restaurant Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: phoneNumber,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEB7450)),
                  ),
                  labelText: 'Phone Number',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: aboutMe,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEB7450)),
                  ),
                  labelText: 'About Me',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: foodCategories,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEB7450)),
                  ),
                  labelText: 'Food Categories',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: email,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEB7450)),
                  ),
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: maxCateringSizePerPerson,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEB7450)),
                  ),
                  labelText: 'Max Catering Size per Person',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: minimumDayNoticeForCatering,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEB7450)),
                  ),
                  labelText: 'Minimum Day Notice for Catering',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: zipCode,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEB7450)),
                  ),
                  labelText: 'Zip Code',
                ),
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                    onPressed: () async {
                      final UserRestaurant? updatedUserRestaurant =
                          await _updateRestaurant(widget.userRestaurant);

                      if (updatedUserRestaurant != null) {
                        Navigator.of(context).pushNamed('home',
                            arguments: widget.userRestaurant.appUser);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4D9F6B),
                      // ignore: prefer_const_constructors
                      textStyle: TextStyle(fontSize: 20),
                    ),
                    child: const Text('Update Restaurant'))),
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
