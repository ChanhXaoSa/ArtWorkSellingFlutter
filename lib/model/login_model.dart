// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String token;
  Accinfo accinfo;

  LoginModel({
    required this.token,
    required this.accinfo,
  });

  LoginModel.empty()
      : token = '',
        accinfo = Accinfo.empty();

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        token: json["token"],
        accinfo: Accinfo.fromJson(json["accinfo"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "accinfo": accinfo.toJson(),
      };
}

class Accinfo {
  dynamic name;
  dynamic address;
  dynamic adminAccounts;
  dynamic audienceAccounts;
  dynamic artistAccounts;
  dynamic interacts;
  dynamic reports;
  dynamic artWorks;
  dynamic orders;
  dynamic wishLists;
  String id;
  String userName;
  String normalizedUserName;
  String email;
  String normalizedEmail;
  bool emailConfirmed;
  String passwordHash;
  String securityStamp;
  String concurrencyStamp;
  dynamic phoneNumber;
  bool phoneNumberConfirmed;
  bool twoFactorEnabled;
  dynamic lockoutEnd;
  bool lockoutEnabled;
  int accessFailedCount;

  Accinfo({
    required this.name,
    required this.address,
    required this.adminAccounts,
    required this.audienceAccounts,
    required this.artistAccounts,
    required this.interacts,
    required this.reports,
    required this.artWorks,
    required this.orders,
    required this.wishLists,
    required this.id,
    required this.userName,
    required this.normalizedUserName,
    required this.email,
    required this.normalizedEmail,
    required this.emailConfirmed,
    required this.passwordHash,
    required this.securityStamp,
    required this.concurrencyStamp,
    required this.phoneNumber,
    required this.phoneNumberConfirmed,
    required this.twoFactorEnabled,
    required this.lockoutEnd,
    required this.lockoutEnabled,
    required this.accessFailedCount,
  });

  Accinfo.empty()
      : name = null,
        address = null,
        adminAccounts = null,
        audienceAccounts = null,
        artistAccounts = null,
        interacts = null,
        reports = null,
        artWorks = null,
        orders = null,
        wishLists = null,
        id = '',
        userName = '',
        normalizedUserName = '',
        email = '',
        normalizedEmail = '',
        emailConfirmed = false,
        passwordHash = '',
        securityStamp = '',
        concurrencyStamp = '',
        phoneNumber = '',
        phoneNumberConfirmed = false,
        twoFactorEnabled = false,
        lockoutEnd = null,
        lockoutEnabled = false,
        accessFailedCount = 0;

  factory Accinfo.fromJson(Map<String, dynamic> json) => Accinfo(
        name: json["name"],
        address: json["address"],
        adminAccounts: json["adminAccounts"],
        audienceAccounts: json["audienceAccounts"],
        artistAccounts: json["artistAccounts"],
        interacts: json["interacts"],
        reports: json["reports"],
        artWorks: json["artWorks"],
        orders: json["orders"],
        wishLists: json["wishLists"],
        id: json["id"],
        userName: json["userName"],
        normalizedUserName: json["normalizedUserName"],
        email: json["email"],
        normalizedEmail: json["normalizedEmail"],
        emailConfirmed: json["emailConfirmed"],
        passwordHash: json["passwordHash"],
        securityStamp: json["securityStamp"],
        concurrencyStamp: json["concurrencyStamp"],
        phoneNumber: json["phoneNumber"],
        phoneNumberConfirmed: json["phoneNumberConfirmed"],
        twoFactorEnabled: json["twoFactorEnabled"],
        lockoutEnd: json["lockoutEnd"],
        lockoutEnabled: json["lockoutEnabled"],
        accessFailedCount: json["accessFailedCount"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "adminAccounts": adminAccounts,
        "audienceAccounts": audienceAccounts,
        "artistAccounts": artistAccounts,
        "interacts": interacts,
        "reports": reports,
        "artWorks": artWorks,
        "orders": orders,
        "wishLists": wishLists,
        "id": id,
        "userName": userName,
        "normalizedUserName": normalizedUserName,
        "email": email,
        "normalizedEmail": normalizedEmail,
        "emailConfirmed": emailConfirmed,
        "passwordHash": passwordHash,
        "securityStamp": securityStamp,
        "concurrencyStamp": concurrencyStamp,
        "phoneNumber": phoneNumber,
        "phoneNumberConfirmed": phoneNumberConfirmed,
        "twoFactorEnabled": twoFactorEnabled,
        "lockoutEnd": lockoutEnd,
        "lockoutEnabled": lockoutEnabled,
        "accessFailedCount": accessFailedCount,
      };
}
