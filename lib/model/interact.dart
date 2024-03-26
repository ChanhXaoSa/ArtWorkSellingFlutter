// To parse this JSON data, do
//
//     final interact = interactFromJson(jsonString);

import 'dart:convert';

List<Interact> interactFromJson(String str) => List<Interact>.from(json.decode(str).map((x) => Interact.fromJson(x)));

String interactToJson(List<Interact> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Interact {
  String artWorkId;
  String comment;
  bool isLike;
  DateTime date;
  DateTime created;
  dynamic createdBy;
  dynamic lastModified;
  dynamic lastModifiedBy;
  bool isDeleted;
  String id;
  List<dynamic> domainEvents;

  Interact({
    required this.artWorkId,
    required this.comment,
    required this.isLike,
    required this.date,
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
    comment: json["comment"],
    isLike: json["isLike"],
    date: DateTime.parse(json["date"]),
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
    "comment": comment,
    "isLike": isLike,
    "date": date.toIso8601String(),
    "created": created.toIso8601String(),
    "createdBy": createdBy,
    "lastModified": lastModified,
    "lastModifiedBy": lastModifiedBy,
    "isDeleted": isDeleted,
    "id": id,
    "domainEvents": List<dynamic>.from(domainEvents.map((x) => x)),
  };
}