import 'package:flutter/material.dart';
import 'package:sign_in_system/design/constant.dart';
import 'package:sign_in_system/design/loading.dart';
import 'package:sign_in_system/services/auth_method_file.dart';

class Register extends StatefulWidget {
  final Function changeview;
  const Register(this.changeview, {Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Registerpage.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(50.0, 260.0, 50.0, 20.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        const Text(
                          "Register new user",
                          style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 70.0,
                        ),
                        TextFormField(
                          decoration:
                              textInputDecoration.copyWith(hintText: "Email"),
                          onChanged: (value) {
                            setState(() => email = value);
                          },
                          validator: (value) =>
                              value!.isEmpty ? "Enter valid email" : null,
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: textInputDecoration.copyWith(
                              hintText: "Password"),
                          onChanged: (value) {
                            setState(() => password = value);
                          },
                          validator: (value) =>
                              value!.length < 6 ? "length must be > 6" : null,
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 10.0,
                            ),
                            SizedBox(
                              width: 120.0,
                              height: 50.0,
                              child: ElevatedButton(
                                child: const Text(
                                  "Register",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                ),
                                onPressed: () async {
                                  if (_formkey.currentState!.validate()) {
                                    setState(() => loading = true);
                                    dynamic result =
                                        await _auth.registerUsingCredentials(
                                            email, password);
                                    if (result == null) {
                                      setState(() {
                                        error = "Couldn't register.";
                                        loading = false;
                                      });
                                    }
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          error,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(
                          height: 60.0,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 190.0,
                            ),
                            SizedBox(
                              width: 120.0,
                              height: 50.0,
                              child: ElevatedButton(
                                child: const Text(
                                  "Sign In",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green[900],
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0))),
                                onPressed: () {
                                  widget.changeview();
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
