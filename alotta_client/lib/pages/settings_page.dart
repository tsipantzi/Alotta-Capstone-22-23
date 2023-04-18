import 'dart:developer';

import 'package:alotta_client/assets/services/app_user_service.dart';
import 'package:flutter/material.dart';

import '../assets/colors/colors.dart';
import '../assets/data/app_user.dart';
import '../assets/widgets/alotta_app_bar.dart';
import '../main.dart';

class SettingsPage extends StatefulWidget {
  final AppUser currentUser;
  const SettingsPage({super.key, required this.currentUser});
  static const int pageIndex = 2;

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
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
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
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEB7450)),
                  ),
                  labelText: 'Re-enter Password',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: firstNameController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
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
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEB7450)),
                  ),
                  labelText: 'Last Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEB7450)),
                  ),
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ElevatedButton(
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
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Passwords do not match"),
                          behavior: SnackBarBehavior.floating,
                        ));
                      }
                    },
                    child: const Text('Update Account'))),
          ],
        ),
      ),
      bottomNavigationBar: AlottaNavigationBar(
        currentUser: widget.currentUser,
        context: context,
        selectedIndex: SettingsPage.pageIndex,
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
