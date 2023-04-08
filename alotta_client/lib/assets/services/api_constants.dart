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

  /*
    Coupons without Restaurant Info endpoints
   */
  static String getAllCoupons(final String zipCode) {
    return '$baseUrl$_couponParam$_search?zipCode=$zipCode';
  }

  static String getCouponById(final String couponId) {
    return '$baseUrl$_couponParam/$couponId';
  }

  static String getAllCouponsForSearchTerm(
      final String searchTerm, final String zipCode) {
    return '$baseUrl$_couponParam$_search?searchTerm=$searchTerm&zipCode=$zipCode';
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
}
