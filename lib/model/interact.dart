// To parse this JSON data, do
//
//     final interact = interactFromJson(jsonString);

import 'dart:convert';

Interact interactFromJson(String str) => Interact.fromJson(json.decode(str));

String interactToJson(Interact data) => json.encode(data.toJson());

class Interact {
  String artWorkId;
  String userAccountId;
  dynamic applicationUser;
  String comment;
  DateTime created;
  dynamic createdBy;
  dynamic lastModified;
  dynamic lastModifiedBy;
  bool isDeleted;
  String id;
  List<dynamic> domainEvents;

  Interact({
    required this.artWorkId,
    required this.userAccountId,
    required this.applicationUser,
    required this.comment,
    required this.created,
    required this.createdBy,
    required this.lastModified,
    required this.lastModifiedBy,
    required this.isDeleted,
    required this.id,
    required this.domainEvents,
  });

  factory Interact.fromJson(Map<String, dynamic> json) => Interact(
    artWorkId: json["artWorkID"],
    userAccountId: json["userAccountId"],
    applicationUser: json["applicationUser"],
    comment: json["comment"],
    created: DateTime.parse(json["created"]),
    createdBy: json["createdBy"],
    lastModified: json["lastModified"],
    lastModifiedBy: json["lastModifiedBy"],
    isDeleted: json["isDeleted"],
    id: json["id"],
    domainEvents: List<dynamic>.from(json["domainEvents"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "artWorkID": artWorkId,
    "userAccountId": userAccountId,
    "applicationUser": applicationUser,
    "comment": comment,
    "created": created.toIso8601String(),
    "createdBy": createdBy,
    "lastModified": lastModified,
    "lastModifiedBy": lastModifiedBy,
    "isDeleted": isDeleted,
    "id": id,
    "domainEvents": List<dynamic>.from(domainEvents.map((x) => x)),
  };
}
