// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

List<Category> categoryFromJson(String str) => List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  String categoryName;
  String description;
  dynamic artWorks;
  DateTime created;
  dynamic createdBy;
  dynamic lastModified;
  dynamic lastModifiedBy;
  bool isDeleted;
  String id;
  List<dynamic> domainEvents;

  Category({
    required this.categoryName,
    required this.description,
    required this.artWorks,
    required this.created,
    required this.createdBy,
    required this.lastModified,
    required this.lastModifiedBy,
    required this.isDeleted,
    required this.id,
    required this.domainEvents,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    categoryName: json["categoryName"],
    description: json["description"],
    artWorks: json["artWorks"],
    created: DateTime.parse(json["created"]),
    createdBy: json["createdBy"],
    lastModified: json["lastModified"],
    lastModifiedBy: json["lastModifiedBy"],
    isDeleted: json["isDeleted"],
    id: json["id"],
    domainEvents: List<dynamic>.from(json["domainEvents"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "categoryName": categoryName,
    "description": description,
    "artWorks": artWorks,
    "created": created.toIso8601String(),
    "createdBy": createdBy,
    "lastModified": lastModified,
    "lastModifiedBy": lastModifiedBy,
    "isDeleted": isDeleted,
    "id": id,
    "domainEvents": List<dynamic>.from(domainEvents.map((x) => x)),
  };
}
