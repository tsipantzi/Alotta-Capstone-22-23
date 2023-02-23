import 'dart:developer';

import 'package:alotta_client/pages/login_page.dart';
import 'package:flutter/material.dart';

import '../assets/data/app_user.dart';
import '../assets/services/app_user_service.dart';
import '../assets/widgets/alotta_app_bar.dart';

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
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEB7450)),
                  ),
                  labelText: 'Username',
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEB7450)),
                  ),
                  labelText: 'Password',
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                controller: pwTestController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEB7450)),
                  ),
                  labelText: 'Re-enter Password',
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: firstNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEB7450)),
                  ),
                  labelText: 'First Name',
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: lastNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEB7450)),
                  ),
                  labelText: 'Last Name',
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEB7450)),
                  ),
                  labelText: 'Email',
                ),
              ),
            ),

            // Radio Buttons * * * * * * * * * * * * * * * * * * * *
            Column(
              children: <Widget>[
                ListTile(
                  title: const Text('Coupon Consumer'),
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
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
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
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Passwords do not match"),
                          behavior: SnackBarBehavior.floating,
                        ));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4D9F6B),
                      // ignore: prefer_const_constructors
                      textStyle: TextStyle(fontSize: 20),
                    ),
                    child: const Text('Create Account'))),
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
