import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sign_in_system/models/user_model.dart';

class Wallet {
  final CollectionReference<UserModel> userWalletRef =
      FirebaseFirestore.instance.collection("Users").withConverter<UserModel>(
            fromFirestore: (snapshots, _) =>
                UserModel.fromJson(snapshots.data()!),
            toFirestore: (userModel, _) => userModel.toJson(),
          );

  Future<void> updateWallet(int? balance, String balanceRef) {
    return userWalletRef
        .doc(balanceRef.toString())
        .update({"Balance": balance});
  }
}
