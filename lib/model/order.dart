// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  String id;
  DateTime created;
  bool isDeleted;
  String buyerAccountId;
  String ownerAccountId;
  String artWorkId;
  int status;

  Order({
    required this.id,
    required this.created,
    required this.isDeleted,
    required this.buyerAccountId,
    required this.ownerAccountId,
    required this.artWorkId,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    created: DateTime.parse(json["created"]),
    isDeleted: json["isDeleted"],
    buyerAccountId: json["buyerAccountId"],
    ownerAccountId: json["ownerAccountId"],
    artWorkId: json["artWorkID"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created": created.toIso8601String(),
    "isDeleted": isDeleted,
    "buyerAccountId": buyerAccountId,
    "ownerAccountId": ownerAccountId,
    "artWorkID": artWorkId,
    "status": status,
  };
}
