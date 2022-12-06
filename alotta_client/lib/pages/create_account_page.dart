import 'package:flutter/material.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Alotta Logo',
                  style: TextStyle(
                      color: Color(0xFFEB7450),
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),

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
                controller: passwordController,
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
              children: [
                RadioListTile(
                  title: const Text("Coupon Creator"),
                  value: "creator",
                  groupValue: "creator",
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                RadioListTile(
                  title: const Text("Coupon Consumer"),
                  value: "creator",
                  groupValue: "consumer",
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ],
            ),

            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                    onPressed: () {
                      // Create account ...
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4D9F6B),
                      // ignore: prefer_const_constructors
                      textStyle: TextStyle(fontSize: 20),
                    ),
                    child: const Text('Create Account'))),
            // Row(
            //   children: <Widget>[
            //     const Text('Don\'t have account?'),
            //     TextButton(
            //       child: const Text(
            //         'Sign in',
            //         style: TextStyle(fontSize: 20),
            //       ),
            //       onPressed: () {
            //         //signup screen
            //       },
            //     )
            //   ],
            //   mainAxisAlignment: MainAxisAlignment.center,
            // ),
          ],
        ));
  }
}
