import 'dart:convert';
import 'dart:developer';
import 'package:alotta_client/assets/data/coupon.dart';
import 'package:http/http.dart' as http;

import 'api_constants.dart';

class CouponService {
  CouponService();

  Future<List<Coupon>?> getAllCoupons(final String restaurantId) async {
    try {
      var url = Uri.parse(ApiConstants.couponsForRestaurantId(restaurantId));
      print('Trying to find coupons by url $url');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return couponsFromJson(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  List<Coupon> couponsFromJson(String body) {
    print('Got JSON Body $body');
    Iterable couponIterable = jsonDecode(body);
    print('Got Iterable $couponIterable');
    return List.from(couponIterable.map((json) => Coupon.fromJson(json)));
  }

  Future<bool> createCoupon(
      final Coupon coupon, final String restaurantId) async {
    var url = Uri.parse(ApiConstants.couponsForRestaurantId(restaurantId));
    print('Creating Coupon $coupon');

    var body = json.encode(coupon.toJson());

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    return response.statusCode == 200;
  }
}