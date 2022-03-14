import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_system/design/constant.dart';
import 'package:sign_in_system/models/current_user.dart';
import 'package:sign_in_system/models/user_model.dart';
import 'package:sign_in_system/screens/extrapages/droplist.dart';
import 'package:sign_in_system/screens/extrapages/wallet.dart';
import 'package:sign_in_system/services/auth_method_file.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService auth = AuthService();
  int? walletBalance;
  final Wallet wallet = Wallet();
  TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var amount = textController.text;
    final user = Provider.of<CurrentUser>(context);

    final Query<UserModel> userRef = FirebaseFirestore.instance
        .collection('Users')
        .where('Uid', isEqualTo: user.uid)
        .withConverter<UserModel>(
          fromFirestore: (snapshots, _) =>
              UserModel.fromJson(snapshots.data()!),
          toFirestore: (userModel, _) => userModel.toJson(),
        );

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home Page"),
        actions: [
          TextButton.icon(
            onPressed: () {
              auth.signOut();
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

          /* return Container(
            child: Column(
              children: [
                CircleAvatar(
                  Text(data.docs.),
                )
              ],
            ),
          ); */
          return Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.docs[0].data().name,
                  style: const TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text("Address : ${data.docs[0].data().address}"),
                const SizedBox(
                  height: 20.0,
                ),
                Text("Age : ${data.docs[0].data().age}"),
                const SizedBox(
                  height: 80.0,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    const Text("Wallet balance :"),
                    const SizedBox(
                      width: 30.0,
                    ),
                    Text(
                      data.docs[0].data().balance.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14.0),
                    ),
                    const SizedBox(
                      width: 30.0,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          walletBalance = walletBalance! + 100;
                        });
                        wallet.updateWallet(
                            walletBalance, data.docs[0].reference.id);
                      },
                      child: Text(
                        "Add Money",
                        style: TextStyle(
                          color: Colors.blue[200],
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 40.0,
                ),
                const Text("Send Money"),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    const Text("Enter amount to send"),
                    const SizedBox(
                      width: 20.0,
                    ),
                    SizedBox(
                      width: 100.0,
                      height: 40.0,
                      child: TextFormField(
                        controller: textController,
                        decoration: textInputDecoration,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "To",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    SizedBox(
                      height: 40.0,
                      width: 80.0,
                      child: DropList(
                        initValue: null,
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /*  Widget listItems() {
    return StreamBuilder<QuerySnapshot<UserModel>>(
        stream: wallet.userWalletRef.snapshots(),
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
                title: Text(data.docs[index].data().name),
              );
            },
          );
        });
  } */

}
/* 
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
          return Text(data.docs[0].data().balance.toString());
          // return Text(data.docs[0].data().balance.toString());
        });
  }
} */
