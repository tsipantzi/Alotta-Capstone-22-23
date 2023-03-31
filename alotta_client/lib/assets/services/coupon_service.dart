import 'dart:convert';
import 'dart:developer';

import 'package:alotta_client/assets/data/coupon.dart';
import 'package:http/http.dart' as http;

import 'api_constants.dart';

class CouponService {
  List<Coupon> coupons = List.empty();
  bool cacheIsInvalidated = false;
  CouponService();

  Future<List<Coupon>> getAllCoupons(final String zipCode) async {
    if (coupons.isNotEmpty && !cacheIsInvalidated) return coupons;

    try {
      var url = Uri.parse(ApiConstants.getAllCoupons(zipCode));
      log('Trying to find coupons by url $url');
      var response = await http.get(url);
      if (response.statusCode == 200 && response.body != '[]') {
        coupons = couponsFromJson(response.body);
        return coupons;
      }
    } catch (e) {
      log(e.toString());
    }
    return List.empty();
  }

  Future<List<Coupon>> getAllCouponsBySearchTerm(
      String value, String zipCode) async {
    cacheIsInvalidated = true;
    try {
      var url =
          Uri.parse(ApiConstants.getAllCouponsForSearchTerm(value, zipCode));
      log('Trying to find coupons by url $url');
      var response = await http.get(url);
      if (response.statusCode == 200 && response.body != '[]') {
        coupons = couponsFromJson(response.body);
        return coupons;
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
}
