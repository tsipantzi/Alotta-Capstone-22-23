class ApiConstants {
  static const String baseUrl = "http://alotta-spring-app.azurewebsites.net";
  static const String _restaurantParam = "/restaurant";
  static const String _couponParam = "/coupon";
  static const String _appUserParam = "/appuser";
  static const String _userRestaurantsParam = "/user/restaurants";
  static const String _update = '/update';
  static const String _create = '/create';

  static String couponsForRestaurantId(final String restaurantId) {
    return '$baseUrl$_restaurantParam/$restaurantId$_couponParam';
  }

  static String couponByRestaurantId(
      final String restaurantId, final String couponId) {
    return '$baseUrl$_restaurantParam/$restaurantId$_couponParam/$couponId';
  }

  static String getAppUserUrl(final String username, final String password) {
    return '$baseUrl$_appUserParam?username=$username&password=$password';
  }

  static String createAppUserUrl() {
    return '$baseUrl$_appUserParam$_create';
  }

  static String userRestaurantsUrl() {
    return '$baseUrl$_userRestaurantsParam';
  }

  static String updateAppUserUrl() {
    return '$baseUrl$_appUserParam$_update';
  }

  static String getRestaurantsForUserUrl(final int userId) {
    return '$baseUrl$_userRestaurantsParam?userId=$userId';
  }
}
