class ApiConstants {
  static const String baseUrl = "http://alotta-spring-app.azurewebsites.net";
  static const String _restaurantParam = "/restaurant";
  static const String _couponParam = "/coupons";
  static const String _appUserParam = "/appuser";
  static const String _userIdParam = "/userId";
  static const String _saveParam = "/save";
  static const String _userRestaurantsParam = "/user/restaurants";
  static const String _update = '/update';
  static const String _create = '/create';
  static const String _search = '/search';
  static const String _qr = '/qr';

  /*
   Coupons by Restaurant endpoints
   */
  static String couponsForRestaurantId(final String restaurantId) {
    return '$baseUrl$_restaurantParam/$restaurantId$_couponParam';
  }

  static String couponForRestaurantId(
      final String restaurantId, final String couponId) {
    return '$baseUrl$_restaurantParam/$restaurantId$_couponParam/$couponId';
  }

  /*
    Coupons without Restaurant Info endpoints
   */
  static String getAllCoupons() {
    return '$baseUrl$_couponParam$_search';
  }

  static String getCouponById(final String couponId) {
    return '$baseUrl$_couponParam/$couponId';
  }

  static String getAllCouponsForSearchTerm(final String searchTerm) {
    return '$baseUrl$_couponParam$_search?searchTerm=$searchTerm';
  }

  /*
    AppUser endpoints
   */
  static String getAppUserUrl(final String username, final String password) {
    return '$baseUrl$_appUserParam?username=$username&password=$password';
  }

  static String createAppUserUrl() {
    return '$baseUrl$_appUserParam$_create';
  }

  /*
    Restaurant by AppUser endpoints
   */
  static String userRestaurantsUrl() {
    return '$baseUrl$_userRestaurantsParam';
  }

  static String updateAppUserUrl() {
    return '$baseUrl$_appUserParam$_update';
  }

  static String getRestaurantsForUserUrl(final int userId) {
    return '$baseUrl$_userRestaurantsParam?userId=$userId';
  }

  static String getRestaurantsForZipCode(final String zipCode) {
    return '$baseUrl$_userRestaurantsParam?zipCode=$zipCode';
  }

  /*
    CustomerInventory endpoints
   */
  static String getAllClaimedCouponsForCustomerUrl(final int userId) {
    return '$baseUrl$_userIdParam/$userId$_couponParam';
  }

  static String saveCouponForCustomerUrl(final int userId, final int couponId) {
    return '$baseUrl$_userIdParam/$userId$_couponParam/$couponId$_saveParam';
  }

  static String getQRCodeForCustomerAndCouponUrl(
      final int userId, final int couponId) {
    return '$baseUrl$_userIdParam/$userId$_couponParam/$couponId$_qr';
  }

  static String deleteCouponForCustomerUrl(
      final int userId, final int couponId) {
    return '$baseUrl$_userIdParam/$userId$_couponParam/$couponId';
  }
}
