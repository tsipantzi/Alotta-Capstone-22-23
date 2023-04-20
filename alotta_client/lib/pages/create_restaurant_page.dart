import 'dart:developer';

import 'package:alotta_client/assets/data/app_user.dart';
import 'package:alotta_client/assets/widgets/alotta_app_bar.dart';
import 'package:alotta_client/assets/widgets/food_category_bubble.dart';
import 'package:alotta_client/main.dart';
import 'package:flutter/material.dart';

import '../assets/data/food_category_type.dart';
import '../assets/data/restaurant.dart';
import '../assets/data/user_restaurant.dart';
import '../assets/services/restaurant_service.dart';

class CreateRestaurantPage extends StatefulWidget {
  final AppUser currentUser;
  List<String> selectedCategories = <String>[];
  CreateRestaurantPage({super.key, required this.currentUser});

  @override
  State<CreateRestaurantPage> createState() => _CreateRestaurantPage();
}

class _CreateRestaurantPage extends State<CreateRestaurantPage> {
  final TextEditingController restaurantName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController aboutMe = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController maxCateringSizePerPerson =
      TextEditingController();
  final TextEditingController minimumDayNoticeForCatering =
      TextEditingController();
  final TextEditingController zipCode = TextEditingController();

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
              height: 90,
              padding: const EdgeInsets.fromLTRB(0, 22.5, 0, 22.5),
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
                hintText: 'Zip Code',
                controller: zipCode,
              ),
            ),
            Container(
                height: 50,
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                    onPressed: () async {
                      final UserRestaurant? createdUserRestaurant =
                          await _createRestaurant(widget.currentUser);

                      if (createdUserRestaurant != null) {
                        Navigator.of(context)
                            .pushNamed('home', arguments: widget.currentUser);
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

  Future<UserRestaurant?> _createRestaurant(AppUser currentUser) async {
    final Restaurant restaurantToCreate = Restaurant(
      name: restaurantName.value.text,
      phoneNumber: phoneNumber.value.text,
      aboutMe: aboutMe.value.text,
      foodCategories: widget.selectedCategories.join(','),
      email: email.value.text,
      maxCateringSizePerPerson: int.parse(maxCateringSizePerPerson.value.text),
      minimumNotice: int.parse(minimumDayNoticeForCatering.value.text),
      zipCode: zipCode.value.text,
    );

    log('Creating restaurant ${restaurantToCreate.name}');
    final RestaurantService service = RestaurantService();

    UserRestaurant userRestaurantRequest =
        UserRestaurant(restaurant: restaurantToCreate, appUser: currentUser);

    return await service.createUserRestaurant(userRestaurantRequest);
  }
}
