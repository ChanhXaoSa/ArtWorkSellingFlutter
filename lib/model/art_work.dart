// To parse this JSON data, do
//
//     final artWork = artWorkFromJson(jsonString);

import 'dart:convert';

List<ArtWork> artWorkFromJson(String str) => List<ArtWork>.from(json.decode(str).map((x) => ArtWork.fromJson(x)));

String artWorkToJson(List<ArtWork> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ArtWork {
  dynamic applicationUser;
  String userAccountId;
  String userOwnerId;
  String name;
  String description;
  int price;
  String imageUrl;
  int artWorkStatus;
  bool isSold;
  bool isPreOrder;
  dynamic orders;
  dynamic interacts;
  DateTime created;
  dynamic createdBy;
  dynamic lastModified;
  dynamic lastModifiedBy;
  bool isDeleted;
  String id;
  List<dynamic> domainEvents;

  ArtWork({
    required this.applicationUser,
    required this.userAccountId,
    required this.userOwnerId,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.artWorkStatus,
    required this.isSold,
    required this.isPreOrder,
    required this.orders,
    required this.interacts,
    required this.created,
    required this.createdBy,
    required this.lastModified,
    required this.lastModifiedBy,
    required this.isDeleted,
    required this.id,
    required this.domainEvents,
  });

  factory ArtWork.fromJson(Map<String, dynamic> json) => ArtWork(
    applicationUser: json["applicationUser"],
    userAccountId: json["userAccountId"],
    userOwnerId: json["userOwnerId"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    imageUrl: json["imageUrl"],
    artWorkStatus: json["artWorkStatus"],
    isSold: json["isSold"],
    isPreOrder: json["isPreOrder"],
    orders: json["orders"],
    interacts: json["interacts"],
    created: DateTime.parse(json["created"]),
    createdBy: json["createdBy"],
    lastModified: json["lastModified"],
    lastModifiedBy: json["lastModifiedBy"],
    isDeleted: json["isDeleted"],
    id: json["id"],
    domainEvents: List<dynamic>.from(json["domainEvents"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "applicationUser": applicationUser,
    "userAccountId": userAccountId,
    "userOwnerId": userOwnerId,
    "name": name,
    "description": description,
    "price": price,
    "imageUrl": imageUrl,
    "artWorkStatus": artWorkStatus,
    "isSold": isSold,
    "isPreOrder": isPreOrder,
    "orders": orders,
    "interacts": interacts,
    "created": created.toIso8601String(),
    "createdBy": createdBy,
    "lastModified": lastModified,
    "lastModifiedBy": lastModifiedBy,
    "isDeleted": isDeleted,
    "id": id,
    "domainEvents": List<dynamic>.from(domainEvents.map((x) => x)),
  };
}
