import 'package:alotta_client/assets/data/app_user.dart';
import 'package:flutter/material.dart';

class NewRestaurantPage extends StatelessWidget {
  const NewRestaurantPage({super.key, required AppUser currentUser});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Column(
        children: const [
          Text('Place Holder Page'),
        ],
      ),
    );
  }
}
