import 'dart:developer';

import 'package:alotta_client/assets/services/app_user_service.dart';
import 'package:alotta_client/assets/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

import '../assets/data/app_user.dart';
import '../assets/widgets/alotta_app_bar.dart';
import '../main.dart';

class SettingsPage extends StatefulWidget {
  final AppUser currentUser;
  const SettingsPage({super.key, required this.currentUser});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController pwTestController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    passwordController.text = widget.currentUser.password;
    pwTestController.text = widget.currentUser.password;
    firstNameController.text = widget.currentUser.firstName;
    lastNameController.text = widget.currentUser.lastName;
    emailController.text = widget.currentUser.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AlottaTitle(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              child: MyApp.platformTextField(
                labelText: 'Password',
                controller: passwordController,
                obscureText: true,
                prefixIcon: const Icon(Icons.lock),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: MyApp.platformTextField(
                labelText: 'Re-enter Password',
                controller: pwTestController,
                obscureText: true,
                prefixIcon: const Icon(Icons.lock_reset),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: MyApp.platformTextField(
                labelText: 'First Name',
                controller: firstNameController,
                prefixIcon: const Icon(Icons.person),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: MyApp.platformTextField(
                labelText: 'Last Name',
                controller: lastNameController,
                prefixIcon: const Icon(Icons.person),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: MyApp.platformTextField(
                labelText: 'Email',
                controller: emailController,
                prefixIcon: const Icon(Icons.email),
              ),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: RoundedButton(
                onPressed: () async {
                  var updatedAppUser = await _updateUser();
                  // Create account ...
                  if (passwordController.value.text ==
                      pwTestController.value.text) {
                    if (updatedAppUser != null) {
                      Navigator.of(context)
                          .pushNamed('home', arguments: widget.currentUser);
                    } else {
                      log('User was not updated');
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Passwords do not match"),
                      behavior: SnackBarBehavior.floating,
                    ));
                  }
                },
                text: 'Update Account',
                context: context,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AlottaNavigationBar(
        currentUser: widget.currentUser,
        context: context,
        selectedIndex:
            widget.currentUser.accountType == AppUserAccountType.CREATOR
                ? 2
                : 3,
      ),
    );
  }

  Future<AppUser?> _updateUser() async {
    final AppUser userToCreate = AppUser(
      username: widget.currentUser.username,
      password: passwordController.value.text,
      firstName: firstNameController.value.text,
      lastName: lastNameController.value.text,
      email: emailController.value.text,
      accountType: widget.currentUser.accountType,
      phoneNumber: '1111111111',
      zipcode: '12345',
    );
    log('Creating user with type $userToCreate');
    final AppUserService service = AppUserService();
    return await service.updateAppUser(userToCreate);
  }
}
