
import 'package:alotta_client/pages/coupon_home_page.dart';
import 'package:alotta_client/pages/create_account_page.dart';
import 'package:alotta_client/pages/login_page.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch(settings.name) {
    case 'login':
      return MaterialPageRoute(builder: (context) => const LoginPage());
    case 'createAccount':
      return MaterialPageRoute(builder: (context) => const CreateAccountPage());
    case 'home':
      return MaterialPageRoute(builder: (context) => const CouponHomePage());
    default:
      return MaterialPageRoute(builder: (context) => const CouponHomePage());
  }
}