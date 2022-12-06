
import 'package:flutter/material.dart';

import '../colors/colors.dart';

class AlottaAppBar extends AppBar {
  AlottaAppBar({super.key}):super(
    title: Image.asset('images/title.png', fit: BoxFit.fill),
    shadowColor: Colors.transparent,
    backgroundColor: primaryCream,
    toolbarHeight: 110,
  );
}