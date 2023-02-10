import 'package:alotta_client/assets/widgets/router.dart' as router;
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
        scaffoldBackgroundColor: const Color(0xFFF8F4EB),
        fontFamily: 'Lato',
      ),
    );
  }
}
