import 'dart:convert';

List<WalletModel> userFromJson(String str) => List<WalletModel>.from(
    json.decode(str).map((x) => WalletModel.fromJson(x)));

String userToJson(List<WalletModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WalletModel {
  WalletModel({this.balance, this.user});

  int? balance;
  String? user;

  factory WalletModel.fromJson(Map<dynamic, dynamic> json) => WalletModel(
        balance: json["Balance"],
        // user: json["User"],
      );

  Map<String, dynamic> toJson() => {
        "Blance": balance,
        // "User": user,
      };
  @override
  String toString() {
    // TODO: implement toString
    return user.toString() + " " + balance.toString();
  }
}
