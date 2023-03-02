import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import '../data/app_user.dart';
import 'api_constants.dart';

class AppUserService {
  AppUserService();
  static Map<String, String> header = {"Content-Type": "application/json"};

  Future<AppUser?> getAppUser(final AppUser user) async {
    try {
      var url =
          Uri.parse(ApiConstants.getAppUserUrl(user.username, user.password));
      log('Trying to find AppUser by username $user.username');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return appUserFromJson(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<bool> createAppUser(final AppUser user) async {
    var url = Uri.parse(ApiConstants.createAppUserUrl());
    log('Trying to create AppUser by username ${user.username}');
    var response = await http.post(
      url,
      headers: header,
      body: jsonEncode(user.toJson()),
    );
    log('Response was: ${response.body}');
    return response.statusCode == 200;
  }

  Future<AppUser?> updateAppUser(final AppUser user) async {
    try {
      var url = Uri.parse(ApiConstants.updateAppUserUrl());
      log('Trying to update AppUser $user.username');
      var response = await http.put(
        url,
        headers: header,
        body: jsonEncode(user.toJson()),
      );

      return appUserFromJson(response.body);
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<AppUser?> appUserFromJson(String body) async {
    log('Got JSON Body $body');
    var json = jsonDecode(body);
    return AppUser.fromJson(json);
  }
}
