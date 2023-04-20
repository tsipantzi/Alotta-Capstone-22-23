import 'dart:developer';

import 'package:alotta_client/assets/widgets/rounded_button.dart';
import 'package:alotta_client/pages/login_page.dart';
import 'package:flutter/material.dart';

import '../assets/data/app_user.dart';
import '../assets/services/app_user_service.dart';
import '../assets/widgets/alotta_app_bar.dart';
import '../main.dart';

class CreateAccountPage extends StatefulWidget {
  final AppUserService service = AppUserService();
  CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController pwTestController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  AppUserAccountType currentSelectedAccountType = AppUserAccountType.CONSUMER;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AlottaTitle(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            // Text Fields * * * * * * * * * * * * * * * * * * * *
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: MyApp.platformTextField(
                hintText: 'Username',
                controller: usernameController,
                prefixIcon: const Icon(Icons.person),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: MyApp.platformTextField(
                hintText: 'Password',
                controller: passwordController,
                obscureText: true,
                prefixIcon: const Icon(Icons.lock),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: MyApp.platformTextField(
                hintText: 'Re-enter Password',
                controller: pwTestController,
                obscureText: true,
                prefixIcon: const Icon(Icons.lock_reset),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: MyApp.platformTextField(
                hintText: 'First Name',
                controller: firstNameController,
                prefixIcon: const Icon(Icons.person),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: MyApp.platformTextField(
                hintText: 'Last Name',
                controller: lastNameController,
                prefixIcon: const Icon(Icons.person),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: MyApp.platformTextField(
                hintText: 'Email',
                controller: emailController,
                prefixIcon: const Icon(Icons.email),
              ),
            ),
            // Radio Buttons * * * * * * * * * * * * * * * * * * * *
            Column(
              children: <Widget>[
                ListTile(
                  title: const Text('Coupon Consumer'),
                  minVerticalPadding: 5,
                  leading: Radio<AppUserAccountType>(
                    value: AppUserAccountType.CONSUMER,
                    groupValue: currentSelectedAccountType,
                    onChanged: (AppUserAccountType? value) {
                      setState(() {
                        currentSelectedAccountType =
                            AppUserAccountType.CONSUMER;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Coupon Creator'),
                  minVerticalPadding: 5,
                  leading: Radio<AppUserAccountType>(
                    value: AppUserAccountType.CREATOR,
                    groupValue: currentSelectedAccountType,
                    onChanged: (AppUserAccountType? value) {
                      setState(() {
                        currentSelectedAccountType = AppUserAccountType.CREATOR;
                      });
                    },
                  ),
                ),
              ],
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: RoundedButton(
                onPressed: () async {
                  // Create account ...
                  if (passwordController.value.text ==
                      pwTestController.value.text) {
                    if (await _createUser()) {
                      Navigator.of(context).pushNamed('login');
                    } else {
                      log('User was not created');
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Passwords do not match"),
                      behavior: SnackBarBehavior.floating,
                    ));
                  }
                },
                text: 'Create Account',
                context: context,
              ),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: RoundedButton(
                onPressed: () async {
                  Navigator.of(context).pushNamed('login');
                },
                text: 'Back',
                context: context,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _createUser() async {
    final AppUser userToCreate = AppUser(
      username: usernameController.value.text,
      password: passwordController.value.text,
      firstName: firstNameController.value.text,
      lastName: lastNameController.value.text,
      email: emailController.value.text,
      accountType: currentSelectedAccountType,
      phoneNumber: '1111111111',
      zipcode: '12345',
    );
    log('Creating user with type $userToCreate');
    return await widget.service.createAppUser(userToCreate);
  }
}
