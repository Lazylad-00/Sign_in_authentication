import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_system/models/user_model.dart';
import 'package:sign_in_system/screens/extrapages/wallet.dart';

class DropList extends StatefulWidget {
  String? initValue;
  DropList({Key? key, this.initValue}) : super(key: key);

  @override
  _DropListState createState() => _DropListState();
}

class _DropListState extends State<DropList> {
  final Wallet wallet = Wallet();

  var initValue;

  @override
  Widget build(BuildContext context) {
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

        final listData = snapshot.requireData;
        List<String> dataList = list(listData);

        return DropdownButton<String>(
          value: initValue,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? newValue) {
            setState(() {
              initValue = newValue!;
              print(initValue);
            });
          },
          items: dataList.map((String items) {
            return DropdownMenuItem<String>(
              value: items,
              child: Text(items),
            );
          }).toList(),
        );
      },
    );
  }

  List<String> list(
    QuerySnapshot<UserModel> data,
  ) {
    List<String> items = [];
    int i = 0;
    while (i < data.docs.length) {
      items.add(data.docs[i].data().name);
      i++;
    }
    return items;
  }
}
