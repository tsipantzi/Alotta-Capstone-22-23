import 'dart:convert';
import 'dart:developer';
import 'package:alotta_client/assets/data/coupon.dart';
import 'package:alotta_client/assets/data/coupon_search_options.dart';
import 'package:http/http.dart' as http;

import 'api_constants.dart';

class CouponService {
  CouponService();

  Future<List<Coupon>> getAllCoupons() async {
    try {
      var url = Uri.parse(ApiConstants.getAllCoupons());
      log('Trying to find coupons by url $url');
      var response = await http.get(url);
      if (response.statusCode == 200 && response.body != '[]') {
        return couponsFromJson(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
    return List.empty();
  }

  Future<List<Coupon>> getAllCouponsByRestaurantId(
      final String restaurantId) async {
    try {
      var url = Uri.parse(ApiConstants.couponsForRestaurantId(restaurantId));
      log('Trying to find coupons by url $url');
      var response = await http.get(url);
      if (response.statusCode == 200 && response.body != '[]') {
        return couponsFromJson(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
    return List.empty();
  }

  List<Coupon> couponsFromJson(String body) {
    log('Got JSON Body $body');
    Iterable couponIterable = jsonDecode(body);
    log('Got Iterable $couponIterable');
    return List.from(couponIterable.map((json) => Coupon.fromJson(json)));
  }

  Future<bool> createCoupon(
      final Coupon coupon, final String restaurantId) async {
    var url = Uri.parse(ApiConstants.couponsForRestaurantId(restaurantId));
    log('Creating Coupon $coupon');

    var body = json.encode(coupon.toJson());

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    return response.statusCode == 200;
  }

  Future<List<Coupon>> getAllCouponsBySearchTerm(String value) async {
    try {
      var url = Uri.parse(ApiConstants.getAllCouponsForSearchTerm(value));
      log('Trying to find coupons by url $url');
      var response = await http.get(url);
      if (response.statusCode == 200 && response.body != '[]') {
        return couponsFromJson(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
    return List.empty();
  }

  Future<List<Coupon>> getAllCouponsByOptions(
      CouponSearchOptions options) async {
    try {
      var url = Uri.parse(ApiConstants.getAllCouponsForOptions(options));
      log('Trying to find coupons by url $url');
      var response = await http.get(url);
      if (response.statusCode == 200 && response.body != '[]') {
        return couponsFromJson(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
    return List.empty();
  }
}
