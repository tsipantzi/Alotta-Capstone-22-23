import 'package:alotta_client/assets/widgets/router.dart' as router;
import 'package:alotta_client/pages/create_account_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: router.generateRoute,
      initialRoute: 'createAccount',
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8F4EB),
        fontFamily: 'Lato',
      ),

      // ignore: prefer_const_constructors
      home: Scaffold(
        body: const CreateAccountPage(),
      ),
    );
  }
}