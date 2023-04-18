import 'dart:io';

import 'package:alotta_client/assets/colors/colors.dart';
import 'package:flutter/material.dart';

import 'assets/widgets/router.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: 'login',
      title: 'Flutter Demo',
      theme: ThemeData(
        splashColor: primaryGreen,
        primarySwatch: primaryOrangeMaterialColor,
        cardColor: primaryOrangeMaterialColor,
        cardTheme: CardTheme(
            elevation: 16.0,
            surfaceTintColor: primaryGreen,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0))),
        scaffoldBackgroundColor: const Color(0xFFF8F4EB),
        primaryTextTheme: TextTheme(
          headline1: platformHeadingStyle,
          bodyText1: platformBodyStyle,
        ),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(primaryGreen),
          ),
        ),
      ),
    );
  }

  static TextStyle get platformHeadingStyle {
    if (Platform.isIOS) {
      return const TextStyle(
        fontFamily: 'San Francisco',
        fontWeight: FontWeight.w800,
        fontSize: 24.0,
        color: primaryCream,
      );
    } else if (Platform.isAndroid) {
      return const TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w600,
        fontSize: 24.0,
        color: primaryCream,
      );
    } else {
      return const TextStyle(
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.w800,
        fontSize: 24.0,
        color: primaryCream,
      );
    }
  }

  static TextStyle get platformBodyStyle {
    if (Platform.isIOS) {
      return const TextStyle(
        fontFamily: 'San Francisco',
        fontSize: 16.0,
        color: primaryCream,
      );
    } else if (Platform.isAndroid) {
      return const TextStyle(
        fontFamily: 'Roboto',
        fontSize: 16.0,
        color: primaryCream,
      );
    } else {
      return const TextStyle(
        fontFamily: 'Open Sans',
        fontSize: 16.0,
        color: primaryCream,
      );
    }
  }
}
