import 'package:alotta_client/assets/data/app_user.dart';
import 'package:alotta_client/pages/coupon_home_page.dart';
import 'package:alotta_client/pages/create_account_page.dart';
import 'package:alotta_client/pages/login_page.dart';
import 'package:alotta_client/pages/new_restaurant_page.dart';
import 'package:alotta_client/pages/settings_page.dart';
import 'package:flutter/material.dart';

import '../../pages/restaurant_manager_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case 'login':
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case 'createAccount':
        return MaterialPageRoute(
            builder: (context) => const CreateAccountPage());
      case 'home':
        {
          if (args is AppUser) {
            switch (args.accountType) {
              case AppUserAccountType.ADMIN:
              case AppUserAccountType.CONSUMER:
                {
                  return MaterialPageRoute(
                      builder: (context) => CouponHomePage(currentUser: args));
                }
              case AppUserAccountType.CREATOR:
                {
                  return MaterialPageRoute(
                      builder: (context) =>
                          RestaurantManagerPage(currentUser: args));
                }
              case AppUserAccountType.UNKNOWN:
              default:
                return _errorRoute();
            }
          }
          return _errorRoute();
        }

      case 'settings':
        {
          if (args is AppUser) {
            return MaterialPageRoute(
                builder: (context) => SettingsPage(currentUser: args));
          }
          return _errorRoute();
        }

      case 'newRestaurant':
        {
          if (args is AppUser) {
            return MaterialPageRoute(
                builder: (context) => NewRestaurantPage(currentUser: args));
          }
          return _errorRoute();
        }
      default:
        return MaterialPageRoute(builder: (context) => const LoginPage());
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
