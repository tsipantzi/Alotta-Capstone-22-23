import 'package:json_annotation/json_annotation.dart';

part 'app_user.g.dart';

@JsonSerializable()
class AppUser {
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String email;
  final String accountType;
  final String phoneNumber;
  final String zipcode;

  const AppUser({
    this.username = '',
    this.password = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.accountType = '',
    this.phoneNumber = '',
    this.zipcode = '',
  });

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}
