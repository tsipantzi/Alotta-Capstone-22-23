// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser(
      id: (json['id'] as num?)?.toDouble() ?? 0,
      username: json['username'] as String? ?? '',
      password: json['password'] as String? ?? '',
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      accountType: $enumDecodeNullable(
              _$AppUserAccountTypeEnumMap, json['accountType']) ??
          AppUserAccountType.UNKNOWN,
      phoneNumber: json['phoneNumber'] as String? ?? '',
      zipcode: json['zipcode'] as String? ?? '',
    );

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'password': instance.password,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'accountType': _$AppUserAccountTypeEnumMap[instance.accountType]!,
      'phoneNumber': instance.phoneNumber,
      'zipcode': instance.zipcode,
    };

const _$AppUserAccountTypeEnumMap = {
  AppUserAccountType.CONSUMER: 'consumer',
  AppUserAccountType.CREATOR: 'creator',
  AppUserAccountType.ADMIN: 'admin',
  AppUserAccountType.UNKNOWN: 'UNKNOWN',
};
