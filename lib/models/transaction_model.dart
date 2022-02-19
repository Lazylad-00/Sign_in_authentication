import 'dart:convert';

List<TransactionModel> userFromJson(String str) => List<TransactionModel>.from(
    json.decode(str).map((x) => TransactionModel.fromJson(x)));

String userToJson(List<TransactionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransactionModel {
  TransactionModel(
      {this.dateTime, this.comment, this.amount, this.from, this.to});

  int? dateTime;
  String? comment;
  int? amount;
  String? from;
  String? to;

  factory TransactionModel.fromJson(Map<dynamic, dynamic> json) =>
      TransactionModel(
        dateTime: json["dateTime"],
        comment: json["comment"],
        amount: json["amount"],
        from: json["from"],
        to: json["to"],
      );

  Map<String, dynamic> toJson() => {
        "dateTime": dateTime,
        "comment": comment,
        "amount": amount,
        "from": from,
        "to": to,
      };
}
