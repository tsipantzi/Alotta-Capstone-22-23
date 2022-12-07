import 'dart:convert';

import 'package:http/http.dart' as http;
import '../data/app_user.dart';
import 'api_constants.dart';

class AppUserService {
  AppUserService();

  Future<AppUser?> getAppUser(final AppUser user) async {
    try {
      var url = Uri.parse(ApiConstants.appUserUrl(user.username));
      print('Trying to find AppUser by username $user.username');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return appUserFromJson(response.body);
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<bool> createAppUser(final AppUser user) async {
    var url = Uri.parse(ApiConstants.createAppUserUrl());
    print('Trying to create AppUser by username $user.username');
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(user.toJson()),
    );

    return response.statusCode == 200;
  }

  Future<AppUser?> appUserFromJson(String body) async {
    print('Got JSON Body $body');
    var json = jsonDecode(body);
    return AppUser.fromJson(json);
  }
}
