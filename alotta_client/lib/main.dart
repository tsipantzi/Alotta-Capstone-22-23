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
        fontFamily: 'Nexa',
        primaryTextTheme: const TextTheme(
          bodyText1: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryCream,
            shadows: <Shadow>[
              Shadow(
                color: primaryOrangeMaterialColor,
                offset: Offset(-0.33, 2.53),
                blurRadius: 0,
              ),
            ],
          ),
        ),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(primaryGreen),
          ),
        ),
      ),
    );
  }
}
