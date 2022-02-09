import 'package:flutter/material.dart';
import 'package:sign_in_system/models/current_user.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_system/screens/authenticate/authenticate.dart';
import 'package:sign_in_system/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser?>(context);

    if (user == null) {
      return const Authenticate();
    } else {
      return const Home();
    }
  }
}
