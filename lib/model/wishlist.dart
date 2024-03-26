// To parse this JSON data, do
//
//     final wishlist = wishlistFromJson(jsonString);

import 'dart:convert';

Wishlist wishlistFromJson(String str) => Wishlist.fromJson(json.decode(str));

String wishlistToJson(Wishlist data) => json.encode(data.toJson());

class Wishlist {
  String id;
  DateTime created;
  bool isDeleted;
  String userAccountId;
  String artWorkId;

  Wishlist({
    required this.id,
    required this.created,
    required this.isDeleted,
    required this.userAccountId,
    required this.artWorkId,
  });

  factory Wishlist.fromJson(Map<String, dynamic> json) => Wishlist(
    id: json["id"],
    created: DateTime.parse(json["created"]),
    isDeleted: json["isDeleted"],
    userAccountId: json["userAccountId"],
    artWorkId: json["artWorkID"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created": created.toIso8601String(),
    "isDeleted": isDeleted,
    "userAccountId": userAccountId,
    "artWorkID": artWorkId,
  };
}
