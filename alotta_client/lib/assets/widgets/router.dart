
import 'package:alotta_client/pages/coupon_home_page.dart';
import 'package:alotta_client/pages/create_account_page.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch(settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => LoginPage());
    case 'createAccountPage':
      return MaterialPageRoute(builder: (context) => CreateAccountPage());
    case 'home':
      return MaterialPageRoute(builder: (context) => CouponHomePage());
  }
}