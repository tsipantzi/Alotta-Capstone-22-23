import 'dart:convert';
import 'dart:developer';

import 'package:alotta_client/assets/data/app_user.dart';
import 'package:alotta_client/assets/data/coupon.dart';
import 'package:http/http.dart' as http;

import 'api_constants.dart';

class CouponService {
  List<Coupon> coupons = List.empty();
  bool cacheIsInvalidated = false;
  CouponService();

  Future<List<Coupon>> getAllCoupons(
    final AppUser user,
  ) async {
    if (coupons.isNotEmpty && !cacheIsInvalidated) return coupons;

    try {
      var url = Uri.parse(ApiConstants.getAllCoupons());
      log('Trying to find coupons by url $url');
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(user.toJson()),
      );

      if (response.statusCode == 200 && response.body != '[]') {
        coupons = couponsFromJson(response.body);
        cacheIsInvalidated = false;
        return coupons;
      }
    } catch (e) {
      log(e.toString());
    }
    return List.empty();
  }

  Future<List<Coupon>> getAllCouponsBySearchTerm(
    final String value,
    final AppUser user,
  ) async {
    try {
      var url = Uri.parse(ApiConstants.getAllCouponsForSearchTerm(value));
      log('Trying to find coupons by url $url');
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(user.toJson()),
      );

      if (response.statusCode == 200 && response.body != '[]') {
        coupons = couponsFromJson(response.body);
        cacheIsInvalidated = true;
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

  Future<void> deleteCouponFromRestaurant(
      final String restaurantId, final Coupon coupon) async {
    var url = Uri.parse(ApiConstants.couponsForRestaurantId(restaurantId));

    var response = await http.delete(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(coupon.toJson()),
    );

    if (response.statusCode == 200) {
      log('Deleted coupon ${coupon.id} from restaurant $restaurantId');
    } else {
      log('Failed to delete coupon ${coupon.id} from restaurant $restaurantId');
    }
  }
}
