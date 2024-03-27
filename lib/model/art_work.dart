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
  List<dynamic> orders;
  List<Interact> interacts;
  dynamic wishLists;
  CategoryModel category;
  DateTime created;
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
    required this.orders,
    required this.interacts,
    required this.wishLists,
    required this.category,
    required this.created,
    required this.isDeleted,
    required this.id,
  });

  ArtWork.empty() :
         userAccountId = '',
   userOwnerId= '',
   categoryId= '',
   name= '',
   description= '',
   price= 0,
   imageUrl= '',
   artWorkStatus= 0,
   orders= [],
   interacts= [],
   wishLists= [],
   category= CategoryModel.isempty(),
   created= DateTime.now(),
   isDeleted= false,
   id= '';

  factory ArtWork.fromJson(Map<String, dynamic> json) => ArtWork(
    userAccountId: json["userAccountId"],
    userOwnerId: json["userOwnerId"],
    categoryId: json["categoryId"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    imageUrl: json["imageUrl"],
    artWorkStatus: json["artWorkStatus"],
    orders: List<dynamic>.from(json["orders"].map((x) => x)),
    interacts: List<Interact>.from(json["interacts"].map((x) => Interact.fromJson(x))),
    wishLists: json["wishLists"],
    category: CategoryModel.fromJson(json["category"]),
    created: DateTime.parse(json["created"]),
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
    "orders": List<dynamic>.from(orders.map((x) => x)),
    "interacts": List<dynamic>.from(interacts.map((x) => x.toJson())),
    "wishLists": wishLists,
    "category": category.toJson(),
    "created": created.toIso8601String(),
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

class ArtWorkInOrderModel {
  String userAccountId;
  String userOwnerId;
  String categoryId;
  String name;
  String description;
  int price;
  String imageUrl;
  int artWorkStatus;
  dynamic wishLists;
  DateTime created;
  bool isDeleted;
  String id;

  ArtWorkInOrderModel({
    required this.userAccountId,
    required this.userOwnerId,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.artWorkStatus,
    required this.wishLists,
    required this.created,
    required this.isDeleted,
    required this.id,
  });

  ArtWorkInOrderModel.empty() :
        userAccountId = '',
        userOwnerId= '',
        categoryId= '',
        name= '',
        description= '',
        price= 0,
        imageUrl= '',
        artWorkStatus= 0,
        wishLists= [],
        created= DateTime.now(),
        isDeleted= false,
        id= '';

  factory ArtWorkInOrderModel.fromJson(Map<String, dynamic> json) => ArtWorkInOrderModel(
    userAccountId: json["userAccountId"],
    userOwnerId: json["userOwnerId"],
    categoryId: json["categoryId"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    imageUrl: json["imageUrl"],
    artWorkStatus: json["artWorkStatus"],
    wishLists: json["wishLists"],
    created: DateTime.parse(json["created"]),
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
    "wishLists": wishLists,
    "created": created.toIso8601String(),
    "isDeleted": isDeleted,
    "id": id,
  };
}