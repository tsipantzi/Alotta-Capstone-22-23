import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

import '../colors/colors.dart';
import 'food_category_type.dart';

part 'coupon.g.dart';

@JsonSerializable()
class Coupon {
  static final _defaultDate = DateTime(0);
  final int id;
  final String title;
  @JsonKey(name: 'couponInfo')
  final String description;
  @JsonKey(fromJson: _fromJsonCategories, toJson: _toJsonCategories)
  final List<FoodCategoryType> foodCategories;
  final Image image = Image.asset('images/coupon_card_placeholder.jpg');
  @JsonKey(name: 'percentageOff')
  final double discount;
  final double dollarsOff;
  final int totalNumberOfCoupons;
  final int numberOfCouponsSold;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  final DateTime startDate;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  final DateTime endDate;

  Coupon({
    this.id = 0,
    this.title = '',
    this.description = '',
    this.discount = 0,
    this.dollarsOff = 0,
    this.totalNumberOfCoupons = 0,
    this.numberOfCouponsSold = 0,
    required this.foodCategories,
    required this.startDate,
    required this.endDate,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);

  Map<String, dynamic> toJson() => _$CouponToJson(this);

  int get numberOfCouponsLeft => totalNumberOfCoupons - numberOfCouponsSold;

  String get startDateShort => DateFormat('MM/dd').format(startDate);
  String get endDateShort => DateFormat('MM/dd').format(endDate);

  static DateTime _fromJson(String date) => DateTime.parse(date);
  static String _toJson(DateTime time) => DateFormat('yyyy-MM-dd').format(time);

  static List<FoodCategoryType> _fromJsonCategories(String foodCategories) {
    final List<FoodCategoryType> foodCategoriesList = [];
    final List<String> foodCategoriesStringList = foodCategories.split(',');
    for (final foodCategory in foodCategoriesStringList) {
      if (foodCategory.trim().isNotEmpty) {
        foodCategoriesList.add(FoodCategoryType.fromString(foodCategory));
      }
    }
    return foodCategoriesList;
  }

  static String _toJsonCategories(List<FoodCategoryType> foodCategories) {
    String foodCategoriesString = '';
    for (final foodCategory in foodCategories) {
      foodCategoriesString += '${foodCategory.name},';
    }
    return foodCategoriesString;
  }

  Container getImage(double height, double width) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        border: Border.all(
          color: Colors.transparent,
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(18.0),
        ),
        child: Image(
          image: image.image,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
