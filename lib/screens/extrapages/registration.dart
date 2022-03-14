import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_system/design/constant.dart';
import 'package:sign_in_system/models/current_user.dart';
import 'package:sign_in_system/models/user_model.dart';
import 'package:sign_in_system/models/wallet_model.dart';
import 'package:sign_in_system/screens/extrapages/wallet.dart';
import 'package:sign_in_system/screens/home/home.dart';
import 'package:sign_in_system/services/auth_method_file.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  Wallet wallet = Wallet();

  @override
  void dispose() {
    // TODO: implement dispose
    namecontroller.dispose();
    agecontroller.dispose();
    addresscontroller.dispose();
    super.dispose();
  }

  /* final CollectionReference<UserModel> userRef = FirebaseFirestore.instance
      .collection('Users')
      .withConverter(
        fromFirestore: (snapshots, _) => UserModel.fromJson(snapshots.data()!),
        toFirestore: (userModel, _) => userModel.toJson(),
      ); */

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CurrentUser>(context);
    Future<void> addUser() {
      return wallet.userWalletRef.add(
        UserModel(
            age: int.parse(agecontroller.text),
            name: namecontroller.text,
            address: addresscontroller.text,
            uid: user.uid,
            balance: 0),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const Text(
                "Registration Form",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Name"),
                controller: namecontroller,
              ),
              const SizedBox(
                height: 40.0,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Age"),
                controller: agecontroller,
              ),
              const SizedBox(
                height: 40.0,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Address"),
                controller: addresscontroller,
              ),
              const SizedBox(
                height: 40.0,
              ),
              const SizedBox(
                height: 40.0,
              ),
              TextButton(
                onPressed: () {
                  addUser();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Home()));
                  /* Navigator.pop(context,
                      MaterialPageRoute(builder: (context) => const Home())); */
                },
                child: const Text("Add User"),
                style: TextButton.styleFrom(backgroundColor: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
