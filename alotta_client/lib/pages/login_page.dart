import 'package:alotta_client/assets/data/app_user.dart';
import 'package:alotta_client/pages/coupon_home_page.dart';
import 'package:alotta_client/pages/create_account_page.dart';
import 'package:flutter/material.dart';

import '../assets/services/app_user_service.dart';
import '../assets/widgets/alotta_app_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AlottaTitle(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(10, 30, 10, 40),
                child: const Text(
                  'Sign in',
                  style: TextStyle(fontSize: 25),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
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
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  onPressed: () async {
                    final AppUser user =
                        await _verifyUserIsLoggedInAndGetUser();
                    if (AppUserAccountType.UNKNOWN == user.accountType) {
                      Navigator.of(context).pushNamed('error');
                    } else {
                      Navigator.of(context).pushNamed('home', arguments: user);
                    }
                  },
                  child: const Text('Sign In'),
                )),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CreateAccountPage()));
                  },
                  child: const Text('Create Account'),
                )),
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text(
                'Forgot Password',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<AppUser> _verifyUserIsLoggedInAndGetUser() async {
    final AppUserService service = AppUserService();
    final AppUser expectedUserInfo = AppUser(
      username: usernameController.value.text,
      password: passwordController.value.text,
    );
    final AppUser? user = await service.getAppUser(expectedUserInfo);
    if (user != null && user.password == expectedUserInfo.password) {
      return user;
    }
    return const AppUser();
  }
}
