import 'package:alotta_client/assets/data/app_user.dart';
import 'package:flutter/material.dart';

class NewRestaurantPage extends StatelessWidget {
  const NewRestaurantPage({super.key, required AppUser currentUser});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'New Restaurant Page',
    );
  }
}
