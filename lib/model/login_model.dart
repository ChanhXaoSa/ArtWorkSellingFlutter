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
  String id;
  String userName;
  String email;
  bool isAdminAccount;
  bool isAudienceAccount;
  bool isArtistAccount;

  Accinfo({
    required this.id,
    required this.userName,
    required this.email,
    required this.isAdminAccount,
    required this.isAudienceAccount,
    required this.isArtistAccount,
  });

  Accinfo.empty()
      : id = '',
        userName = '',
        email = '',
        isAdminAccount = false,
        isAudienceAccount = false,
        isArtistAccount = false;

  factory Accinfo.fromJson(Map<String, dynamic> json) => Accinfo(
        id: json["id"],
        userName: json["userName"],
        email: json["email"],
        isAdminAccount: json["isAdminAccount"],
        isAudienceAccount: json["isAudienceAccount"],
        isArtistAccount: json["isArtistAccount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "email": email,
        "isAdminAccount": isAdminAccount,
        "isAudienceAccount": isAudienceAccount,
        "isArtistAccount": isArtistAccount,
      };
}
