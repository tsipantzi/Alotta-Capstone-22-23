import 'dart:async';

import 'package:flutter/material.dart';

import '../../main.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final BuildContext context;
  final FutureOr<void> Function()? onPressed;

  const RoundedButton(
      {super.key, required this.text, required this.context, this.onPressed});

  Function() defaultBackBehavior() {
    return () => Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 50.0,
      child: ElevatedButton(
        onPressed: onPressed != null
            ? () async => onPressed!()
            : defaultBackBehavior(),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4D9F6B),
          // ignore: prefer_const_constructors
          textStyle: MyApp.platformHeadingStyle.copyWith(fontSize: 20),
        ),
        child: Text(text),
      ),
    );
  }
}
