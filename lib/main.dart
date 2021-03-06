import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_system/models/current_user.dart';
import 'package:sign_in_system/screens/wrapper.dart';
import 'package:sign_in_system/services/auth_method_file.dart';

import 'firebase_config.dart';

Future<void> main() async {
  /* // bool shouldUseFirestoreEmulator = false;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);

  // if (shouldUseFirestoreEmulator) {
  //   FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  // } */
  WidgetsFlutterBinding.ensureInitialized();
  //Firebase.app();
  await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<CurrentUser?>.value(
      initialData: null,
      value: AuthService().user,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: //Home(),
            Wrapper(),
      ),
    );
  }
}
