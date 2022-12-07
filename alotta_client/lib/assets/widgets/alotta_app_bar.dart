import 'package:flutter/material.dart';

import '../colors/colors.dart';

class AlottaTitle extends AppBar {
  AlottaTitle({super.key})
      : super(
          title: Image.asset('images/title.png', fit: BoxFit.fitWidth),
          shadowColor: Colors.transparent,
          backgroundColor: primaryCream,
          toolbarHeight: 110,
          leadingWidth: 0,
        );
}
