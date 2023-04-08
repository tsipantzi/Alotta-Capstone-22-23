import 'package:alotta_client/assets/data/app_user.dart';
import 'package:alotta_client/assets/data/user_restaurant.dart';
import 'package:alotta_client/pages/coupon_home_page.dart';
import 'package:alotta_client/pages/create_account_page.dart';
import 'package:alotta_client/pages/create_coupon_page.dart';
import 'package:alotta_client/pages/create_restaurant_page.dart';
import 'package:alotta_client/pages/login_page.dart';
import 'package:alotta_client/pages/settings_page.dart';
import 'package:flutter/material.dart';

import '../../pages/coupon_manager_page.dart';
import '../../pages/customer_inventory_page.dart';
import '../../pages/edit_restaurant_page.dart';
import '../../pages/qr_code_page.dart';
import '../../pages/restaurant_manager_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case 'login':
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case 'createAccount':
        return MaterialPageRoute(builder: (context) => CreateAccountPage());
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

      case 'createRestaurantPage':
        {
          if (args is AppUser) {
            return MaterialPageRoute(
                builder: (context) => CreateRestaurantPage(currentUser: args));
          }
          return _errorRoute();
        }

      case 'editRestaurantPage':
        {
          if (args is UserRestaurant) {
            return MaterialPageRoute(
                builder: (context) => EditRestaurantPage(userRestaurant: args));
          }
          return _errorRoute();
        }

      case 'couponManagerPage':
        {
          if (args is UserRestaurant) {
            return MaterialPageRoute(
                builder: (context) => CouponManagerPage(userRestaurant: args));
          }
          return _errorRoute();
        }

      case 'createCouponPage':
        {
          if (args is UserRestaurant) {
            return MaterialPageRoute(
                builder: (context) => CreateCouponPage(userRestaurant: args));
          }
          return _errorRoute();
        }
      case 'customerInventoryPage':
        {
          if (args is AppUser) {
            return MaterialPageRoute(
                builder: (context) => CustomerInventoryPage(currentUser: args));
          }
          return _errorRoute();
        }
      case 'qrCodePage':
        {
          if (args is List) {
            return MaterialPageRoute(
                builder: (context) => QrCodePage(args[0], args[1]));
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
