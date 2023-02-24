import 'package:alotta_client/assets/data/app_user.dart';
import 'package:alotta_client/assets/widgets/alotta_app_bar.dart';
import 'package:flutter/material.dart';

import '../assets/colors/colors.dart';
import 'coupon_home_page.dart';


//Need to fix appuser when new Restaurant is fixed
class NewCouponPage extends StatelessWidget {
  const NewCouponPage({super.key//, required AppUser currentUser
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          Text('Place Holder Page'),
        ],
      ),
      bottomNavigationBar: AlottaNavigationBar(
        selectedItemColor: primaryOrangeMaterialColor,
        currentUser: const AppUser(),
        context: context,
        currentIndex: CouponHomePage.pageIndex,
      ),
    );
  }
}
