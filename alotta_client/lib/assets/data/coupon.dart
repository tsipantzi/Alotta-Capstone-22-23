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

  Image getImage() {
    return Image(
      image: image.image,
      height: 100,
      width: 200,
    );
  }
}
