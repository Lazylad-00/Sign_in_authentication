import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_system/models/user_model.dart';

List<WalletModel> userFromJson(String str) => List<WalletModel>.from(
    json.decode(str).map((x) => WalletModel.fromJson(x)));

String userToJson(List<WalletModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WalletModel {
  WalletModel({this.balance, this.user});

  int? balance;
  DocumentReference<UserModel>? user;

  factory WalletModel.fromJson(Map<dynamic, dynamic> json) => WalletModel(
        balance: json["Balance"],
        user: json["User"],
      );

  Map<String, dynamic> toJson() => {
        "Blance": balance,
        "User": user,
      };
  @override
  String toString() {
    // TODO: implement toString
    return user.toString() + " " + balance.toString();
  }
}
