import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LoginScreen());
  }
}

class LoginScreen extends StatelessWidget {
  final TextField field1 = TextField();
  final TextField field2 = TextField();
  final MaterialButton loginButton = MaterialButton(onPressed: () {});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          child: Center(
        child: Column(
          children: [
            Text('WeatherCheck'),
            field1,
            field2,
            loginButton,
            GestureDetector(
              child: Text('Forgot Password'),
              onTap: () {},
            )
          ],
        ),
      )),
    );
  }
}
