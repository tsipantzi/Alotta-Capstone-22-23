import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../data/coupon.dart';
import 'api_constants.dart';

class CustomerInventoryService {
  CustomerInventoryService();

  Future<bool> saveCouponForCustomer(
      final int userId, final int couponId) async {
    var url =
        Uri.parse(ApiConstants.saveCouponForCustomerUrl(userId, couponId));
    log('Saving coupon $couponId for customer $userId');
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
    );
    log('Got result ${response.body}');
    return response.statusCode == 200;
  }

  Future<List<Coupon>> getAllClaimedCouponsForCustomer(final int userId) async {
    try {
      var url =
          Uri.parse(ApiConstants.getAllClaimedCouponsForCustomerUrl(userId));
      log('Trying to find all claimed coupons for user $userId');
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
}
