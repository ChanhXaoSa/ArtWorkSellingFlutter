// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

import 'package:aws_flutter/model/art_work.dart';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

List<Order> orderFromJson(String str) => List<Order>.from(json.decode(str).map((x) => Order.fromJson(x)));

String orderToJson(List<Order> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Order {
  String buyerAccountId;
  String ownerAccountId;
  String artWorkId;
  ArtWorkInOrderModel? artWork;
  int status;
  DateTime created;
  dynamic createdBy;
  DateTime lastModified;
  dynamic lastModifiedBy;
  bool isDeleted;
  String id;
  List<dynamic> domainEvents;

  Order({
    required this.buyerAccountId,
    required this.ownerAccountId,
    required this.artWorkId,
    required this.artWork,
    required this.status,
    required this.created,
    required this.createdBy,
    required this.lastModified,
    required this.lastModifiedBy,
    required this.isDeleted,
    required this.id,
    required this.domainEvents,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    buyerAccountId: json["buyerAccountId"],
    ownerAccountId: json["ownerAccountId"],
    artWorkId: json["artWorkID"],
    artWork: json["artWork"] == null ? null : ArtWorkInOrderModel.fromJson(json["artWork"]),
    status: json["status"],
    created: DateTime.parse(json["created"]),
    createdBy: json["createdBy"],
    lastModified: DateTime.parse(json["lastModified"]),
    lastModifiedBy: json["lastModifiedBy"],
    isDeleted: json["isDeleted"],
    id: json["id"],
    domainEvents: List<dynamic>.from(json["domainEvents"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "buyerAccountId": buyerAccountId,
    "ownerAccountId": ownerAccountId,
    "artWorkID": artWorkId,
    "artWork": artWork?.toJson(),
    "status": status,
    "created": created.toIso8601String(),
    "createdBy": createdBy,
    "lastModified": lastModified.toIso8601String(),
    "lastModifiedBy": lastModifiedBy,
    "isDeleted": isDeleted,
    "id": id,
    "domainEvents": List<dynamic>.from(domainEvents.map((x) => x)),
  };
}

class OrderModel {
  String id;
  DateTime created;
  bool isDeleted;
  String buyerAccountId;
  String ownerAccountId;
  String artWorkId;
  int status;

  OrderModel({
    required this.id,
    required this.created,
    required this.isDeleted,
    required this.buyerAccountId,
    required this.ownerAccountId,
    required this.artWorkId,
    required this.status,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
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
