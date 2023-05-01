import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../data/coupon.dart';
import 'api_constants.dart';

class CustomerInventoryService {
  CustomerInventoryService();

  Future<Coupon?> saveCouponForCustomer(
      final int userId, final int couponId) async {
    var url =
        Uri.parse(ApiConstants.saveCouponForCustomerUrl(userId, couponId));
    log('Saving coupon $couponId for customer $userId');
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return Coupon.fromJson(jsonDecode(response.body));
    }
    log('Got result ${response.body}');
    return null;
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

  //This may not be needed

  Future<Uint8List> getQrCodeForCoupon(
      final int userId, final int couponId) async {
    var url = Uri.parse(
        ApiConstants.getQRCodeForCustomerAndCouponUrl(userId, couponId));
    log('Trying to get QR code for coupon $couponId');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load QR Code');
    }
  }

  Future<void> deleteCoupon(int userId, int couponId) async {
    var url =
        Uri.parse(ApiConstants.deleteCouponForCustomerUrl(userId, couponId));
    log('Deleting coupon $couponId for customer $userId');
    final result = await http.delete(url);
    if (result.statusCode == 200) {
      log('Successfully deleted coupon $couponId for customer $userId');
    } else {
      log('Failed to delete coupon $couponId for customer $userId');
    }
  }
}
