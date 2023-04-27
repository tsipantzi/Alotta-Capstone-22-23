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
        fontSize: 16.0,
        color: Colors.black,
      );
    } else if (Platform.isAndroid) {
      return const TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w800,
        fontSize: 16.0,
        color: Colors.black,
      );
    } else {
      return const TextStyle(
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.w800,
        fontSize: 16.0,
        color: Colors.black,
      );
    }
  }

  static TextStyle get platformBodyStyle {
    if (Platform.isIOS) {
      return const TextStyle(
        letterSpacing: 1,
        fontFamily: 'San Francisco',
        fontSize: 16.0,
        color: Colors.black,
      );
    } else if (Platform.isAndroid) {
      return const TextStyle(
        letterSpacing: 1,
        fontFamily: 'Roboto',
        fontSize: 16.0,
        color: Colors.black,
      );
    } else {
      return const TextStyle(
        letterSpacing: 1,
        fontFamily: 'Open Sans',
        fontSize: 16.0,
        color: Colors.black,
      );
    }
  }

  static TextField platformTextField({
    String? hintText,
    String? labelText,
    Function(String)? onChanged,
    Function()? onTap,
    TextEditingController? controller,
    Icon? prefixIcon,
    bool obscureText = false,
    bool readOnly = false,
  }) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      onTap: onTap,
      obscureText: obscureText,
      readOnly: readOnly,
      style: MyApp.platformHeadingStyle
          .copyWith(color: primaryOrangeMaterialColor, fontSize: 16),
      decoration: _inputDecoration(hintText, labelText)
          .copyWith(prefixIcon: prefixIcon),
    );
  }

  static InputDecoration _inputDecoration(String? hintText, String? labelText) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          width: 4.0,
          color: primaryOrangeMaterialColor,
          style: BorderStyle.solid,
        ),
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: MyApp.platformHeadingStyle
          .copyWith(color: primaryOrangeMaterialColor),
      hintStyle: MyApp.platformHeadingStyle
          .copyWith(color: primaryOrangeMaterialColor),
      prefixIconColor: primaryOrangeMaterialColor,
    );
  }

  static Widget errorDialog(BuildContext context, String message) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: primaryOrangeMaterialColor,
        ),
        width: MediaQuery.of(context).size.width,
        height: 200,
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: Center(
          child: Text(
            message,
            style: MyApp.platformHeadingStyle.copyWith(
              color: primaryCream,
              fontSize: 26,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
