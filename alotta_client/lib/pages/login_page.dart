import 'package:alotta_client/assets/data/app_user.dart';
import 'package:alotta_client/assets/widgets/rounded_button.dart';
import 'package:alotta_client/main.dart';
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
        padding: const EdgeInsets.fromLTRB(10, 100, 10, 0),
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
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
              height: 60,
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: RoundedButton(
                onPressed: () async {
                  final AppUser user = await _verifyUserIsLoggedInAndGetUser();
                  if (AppUserAccountType.UNKNOWN == user.accountType) {
                    Navigator.of(context).pushNamed('error');
                  } else {
                    Navigator.of(context).pushNamed('home', arguments: user);
                  }
                },
                text: 'Sign In',
                context: context,
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: RoundedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CreateAccountPage()));
                  },
                  text: 'Create Account',
                  context: context,
                )),
            // TextButton(
            //   onPressed: () {
            //     //forgot password screen
            //   },
            //   child: const Text(
            //     'Forgot Password',
            //     style: TextStyle(color: Colors.green),
            //   ),
            // ),
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
