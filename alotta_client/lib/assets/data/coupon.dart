import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'coupon.g.dart';

@JsonSerializable()
class Coupon {
  static final _defaultDate = DateTime(0);
  final String title;
  @JsonKey(name: 'couponInfo')
  final String description;
  final Image image = Image.network(
      'https://dash-bootstrap-components.opensource.faculty.ai/static/images/placeholder286x180.png');
  @JsonKey(name: 'percentageOff')
  final double discount;
  final double dollarsOff;
  final int totalNumberOfCoupons;
  final int numberOfCouponsSold;
  final DateTime _startDate;
  final DateTime _endDate;

  Coupon({
    this.title = '',
    this.description = '',
    this.discount = 0,
    this.dollarsOff = 0,
    this.totalNumberOfCoupons = 0,
    this.numberOfCouponsSold = 0,
    DateTime? startDate,
    DateTime? endDate,
  })  : _startDate = startDate ?? _defaultDate,
        _endDate = endDate ?? _defaultDate;

  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);

  Map<String, dynamic> toJson() => _$CouponToJson(this);

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
