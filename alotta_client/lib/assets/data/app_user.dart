import 'package:json_annotation/json_annotation.dart';

part 'app_user.g.dart';

@JsonSerializable()
class AppUser {
  final int id;
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String email;
  final AppUserAccountType accountType;
  final String phoneNumber;
  final String zipcode;

  const AppUser({
    this.id = 0,
    this.username = '',
    this.password = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.accountType = AppUserAccountType.UNKNOWN,
    this.phoneNumber = '',
    this.zipcode = '',
  });

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}

enum AppUserAccountType {
  @JsonValue("consumer")
  CONSUMER,
  @JsonValue("creator")
  CREATOR,
  @JsonValue("admin")
  ADMIN,
  UNKNOWN;
}
