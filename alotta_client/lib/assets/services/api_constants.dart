class ApiConstants {
  static const String baseUrl = "http://alotta-spring-app.azurewebsites.net";
  static const String _restaurantParam = "/restaurant";
  static const String _couponParam = "/coupon";
  static const String _appUserParam = "/appuser";
  static const String _userRestaurantsParam = "/user/restaurants";
  static const String _update = '/update';

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

  static String appUserUrl(final String username) {
    return '$baseUrl$_appUserParam?username=$username';
  }

  static String createAppUserUrl() {
    return '$baseUrl$_appUserParam';
  }

  static String updateAppUserUrl() {
    return '$baseUrl$_appUserParam$_update';
  }

  static String restaurantsForUser(final String username) {
    return '$baseUrl$_userRestaurantsParam?userName=$username';
  }
}
