import 'dart:convert';

List<UserModel> userFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  UserModel({required this.age, required this.name, required this.address
      // , required this.amount
      });

  int age;
  String name;
  String address;
  // int amount;

  factory UserModel.fromJson(Map<dynamic, dynamic> json) => UserModel(
        age: json["Age"],
        name: json["Name"],
        address: json["Address"],
      );

  Map<String, dynamic> toJson() =>
      {"Age": age, "Name": name, "Address": address};
}
