import 'package:flutter/material.dart';
import 'package:sign_in_system/screens/authenticate/register.dart';
import 'package:sign_in_system/screens/authenticate/signin.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void changeView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(changeView);
    } else {
      return Register(changeView);
    }
  }
}
