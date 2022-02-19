import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_system/models/user_model.dart';
import 'package:sign_in_system/models/wallet_model.dart';
import 'package:sign_in_system/services/auth_method_file.dart';

import '../../main.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

final CollectionReference<UserModel> userRef = FirebaseFirestore.instance
    .collection('Users')
    .withConverter<UserModel>(
      fromFirestore: (snapshots, _) => UserModel.fromJson(snapshots.data()!),
      toFirestore: (userModel, _) => userModel.toJson(),
    );

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home Page"),
        actions: [
          TextButton.icon(
            onPressed: () async {
              await _auth.signOut();
            },
            icon: const Icon(
              Icons.person,
              color: Colors.black,
            ),
            label: const Text(
              "Logout",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot<UserModel>>(
        stream: userRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.requireData;

          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  data.docs[index].data().name,
                ),
                subtitle: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      data.docs[index].data().address,
                    ),
                    amount(data.docs[index].reference)
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  amount(DocumentReference<UserModel> userID) {
    final Query<WalletModel> amountRef =

        // Future<QuerySnapshot<Map<String, dynamic>>> amountRef =
        //     FirebaseFirestore.instance
        //         .collection('Wallet')
        //         .where('User', isEqualTo: userID) // arrayContainsAny: ['Fantasy'])
        //         .get();
        // List<WalletModel> list = [];
        // amountRef.then((value) {
        //  list = value.docs.map((doc) => WalletModel.fromJson(doc.data())).toList();
        // });

        FirebaseFirestore.instance
            .collection('Wallet')
            .where('User', isEqualTo: userID)
            .withConverter<WalletModel>(
              fromFirestore: (snapshots, _) =>
                  WalletModel.fromJson(snapshots.data()!),
              toFirestore: (userModel, _) => userModel.toJson(),
            );

    // return FutureBuilder(
    //     future: amountRef,
    //     builder: (context,
    //         AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
    //       List<WalletModel> list = (snapshot.data?.docs
    //               .map((doc) => WalletModel.fromJson(doc.data()))
    //               .toList()) ??
    //           [];
    //       if (list.isNotEmpty) {
    //         return Text(list[0].balance.toString());
    //       } else
    //         return Text("0");
    //       // return Text(snapshot.data?.docs[0].data().);
    //     });

    return StreamBuilder<QuerySnapshot<WalletModel>>(
        stream: amountRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.requireData;
          // return Text(data.docs[0].data().balance.toString());
          return ListView.builder(
              shrinkWrap: true,
              itemCount: data.size,
              itemBuilder: (context, index) {
                return Text(data.docs[index].data().balance.toString());
              });
        });
  }
}
