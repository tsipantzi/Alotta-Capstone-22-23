class ApiConstants {
  static const String baseUrl = "http://10.0.0.245:8080";
  static const String _restaurantParam = "/restaurant";
  static const String _couponParam = "/coupon";

  static String restaurantById(final String restaurantId) {
    return '$baseUrl$_restaurantParam/$restaurantId';
  }

  static String couponsForRestaurantId(final String restaurantId) {
    return '$baseUrl$_restaurantParam/$restaurantId$_couponParam';
  }

  static String couponByRestaurantId(
      final String restaurantId, final String couponId) {
    return '$baseUrl$_restaurantParam/$restaurantId$_couponParam/$couponId';
  }
}
