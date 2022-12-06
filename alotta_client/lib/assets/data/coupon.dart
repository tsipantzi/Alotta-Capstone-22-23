import 'package:flutter/widgets.dart';

class Coupon {
  final String title;
  final String description;
  final Image image;

  const Coupon({
    required this.title,
    required this.description,
    required this.image,
  });

  Image getImage(double height, double width) {
    return Image(
      image: image.image,
      height: height,
      width: width,
    );
  }
}
