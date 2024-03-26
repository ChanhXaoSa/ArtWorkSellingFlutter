// To parse this JSON data, do
//
//     final artWork = artWorkFromJson(jsonString);

import 'dart:convert';

import 'package:aws_flutter/model/category.dart';
import 'package:aws_flutter/model/interact.dart';

ArtWork artWorkFromJson(String str) => ArtWork.fromJson(json.decode(str));

String artWorkToJson(ArtWork data) => json.encode(data.toJson());

class ArtWork {
  String userAccountId;
  String userOwnerId;
  String categoryId;
  String name;
  String description;
  int price;
  String imageUrl;
  int artWorkStatus;
  bool isSold;
  bool isPreOrder;
  List<dynamic> orders;
  List<Interact> interacts;
  dynamic wishLists;
  CategoryModel category;
  DateTime created;
  dynamic createdBy;
  dynamic lastModified;
  dynamic lastModifiedBy;
  bool isDeleted;
  String id;

  ArtWork({
    required this.userAccountId,
    required this.userOwnerId,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.artWorkStatus,
    required this.isSold,
    required this.isPreOrder,
    required this.orders,
    required this.interacts,
    required this.wishLists,
    required this.category,
    required this.created,
    required this.createdBy,
    required this.lastModified,
    required this.lastModifiedBy,
    required this.isDeleted,
    required this.id,
  });

  factory ArtWork.fromJson(Map<String, dynamic> json) => ArtWork(
    userAccountId: json["userAccountId"],
    userOwnerId: json["userOwnerId"],
    categoryId: json["categoryId"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    imageUrl: json["imageUrl"],
    artWorkStatus: json["artWorkStatus"],
    isSold: json["isSold"],
    isPreOrder: json["isPreOrder"],
    orders: List<dynamic>.from(json["orders"].map((x) => x)),
    interacts: List<Interact>.from(json["interacts"].map((x) => Interact.fromJson(x))),
    wishLists: json["wishLists"],
    category: CategoryModel.fromJson(json["category"]),
    created: DateTime.parse(json["created"]),
    createdBy: json["createdBy"],
    lastModified: json["lastModified"],
    lastModifiedBy: json["lastModifiedBy"],
    isDeleted: json["isDeleted"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "userAccountId": userAccountId,
    "userOwnerId": userOwnerId,
    "categoryId": categoryId,
    "name": name,
    "description": description,
    "price": price,
    "imageUrl": imageUrl,
    "artWorkStatus": artWorkStatus,
    "isSold": isSold,
    "isPreOrder": isPreOrder,
    "orders": List<dynamic>.from(orders.map((x) => x)),
    "interacts": List<dynamic>.from(interacts.map((x) => x.toJson())),
    "wishLists": wishLists,
    "category": category.toJson(),
    "created": created.toIso8601String(),
    "createdBy": createdBy,
    "lastModified": lastModified,
    "lastModifiedBy": lastModifiedBy,
    "isDeleted": isDeleted,
    "id": id,
  };
}

class ArtworkModel {
  String imageUrl;
  String categoryId;
  String name;
  String description;
  double price;

  ArtworkModel({required this.imageUrl, required this.categoryId, required this.name, required this.description, required this.price});
}