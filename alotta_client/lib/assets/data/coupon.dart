import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class Coupon {
  static final _defaultDate = DateTime(0);
  final String title;
  final String description;
  final Image image;
  final double discount;
  final double dollarsOff;
  final int totalNumberOfCoupons;
  final int numberOfCouponsSold;
  final DateTime _startDate;
  final DateTime _endDate;

  Coupon({
    required this.title,
    required this.description,
    required this.image,
    this.discount = 0,
    this.dollarsOff = 0,
    this.totalNumberOfCoupons = 0,
    this.numberOfCouponsSold = 0,
    DateTime? startDate,
    DateTime? endDate,
  })  : _startDate = startDate ?? _defaultDate,
        _endDate = endDate ?? _defaultDate;

  int get numberOfCouponsLeft => totalNumberOfCoupons - numberOfCouponsSold;

  String get startDate => DateFormat('MM/dd').format(_startDate);
  String get endDate => DateFormat('MM/dd').format(_endDate);

  Image getImage(double height, double width) {
    return Image(
      image: image.image,
      height: height,
      width: width,
    );
  }
}
