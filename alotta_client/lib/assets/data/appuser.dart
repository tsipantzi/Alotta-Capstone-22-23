import 'package:flutter/widgets.dart';

class Appuser {
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String email;
  final String accountType;

  const Appuser({
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.accountType,
  });
}
