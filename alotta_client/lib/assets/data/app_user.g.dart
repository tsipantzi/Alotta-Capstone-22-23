// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) {
  return AppUser(
    username: json['username'] as String,
    password: json['password'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    email: json['email'] as String,
    accountType: json['accountType'] as String,
    phoneNumber: json['phoneNumber'] as String,
    zipcode: json['zipcode'] as String,
  );
}

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'accountType': instance.accountType,
      'phoneNumber': instance.phoneNumber,
      'zipcode': instance.zipcode,
    };
