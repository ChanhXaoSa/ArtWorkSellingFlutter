// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

import 'package:aws_flutter/model/art_work.dart';

List<Category> categoryFromJson(String str) => List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  String categoryName;
  String description;
  DateTime created;
  dynamic createdBy;
  dynamic lastModified;
  dynamic lastModifiedBy;
  bool isDeleted;
  String id;

  Category({
    required this.categoryName,
    required this.description,
    required this.created,
    required this.createdBy,
    required this.lastModified,
    required this.lastModifiedBy,
    required this.isDeleted,
    required this.id,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    categoryName: json["categoryName"],
    description: json["description"],
    created: DateTime.parse(json["created"]),
    createdBy: json["createdBy"] ?? null,
    lastModified: json["lastModified"] ?? null,
    lastModifiedBy: json["lastModifiedBy"] ?? null,
    isDeleted: json["isDeleted"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "categoryName": categoryName,
    "description": description,
    "created": created.toIso8601String(),
    "createdBy": createdBy,
    "lastModified": lastModified,
    "lastModifiedBy": lastModifiedBy,
    "isDeleted": isDeleted,
    "id": id,
  };
}

class CategoryModel {
  String categoryName;
  String description;
  DateTime created;
  bool isDeleted;
  String id;

  CategoryModel({
    required this.categoryName,
    required this.description,
    required this.created,
    required this.isDeleted,
    required this.id,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    categoryName: json["categoryName"],
    description: json["description"],
    created: DateTime.parse(json["created"]),
    isDeleted: json["isDeleted"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "categoryName": categoryName,
    "description": description,
    "created": created.toIso8601String(),
    "isDeleted": isDeleted,
    "id": id,
  };
}
