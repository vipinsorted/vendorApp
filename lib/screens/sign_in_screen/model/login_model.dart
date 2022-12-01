// To parse this JSON data, do
//
//     final registerUserModel = registerUserModelFromJson(jsonString);

import 'dart:convert';

LoginUserModel loginUserModelFromJson(String str) =>
    LoginUserModel.fromJson(json.decode(str));

String loginUserModelToJson(LoginUserModel data) => json.encode(data.toJson());

class LoginUserModel {
  LoginUserModel({
    this.user,
    this.accessToken,
    this.refreshToken,
  });

  User? user;
  String? accessToken;
  String? refreshToken;

  factory LoginUserModel.fromJson(Map<String, dynamic> json) => LoginUserModel(
        user: User.fromJson(json["user"]),
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user!.toJson(),
        "access_token": accessToken,
        "refresh_token": refreshToken,
      };
}

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.name,
    this.countryCode,
    this.phoneNumber,
    this.email,
    this.avatarUrl,
    this.phoneConfirmedAt,
    this.emailConfirmedAt,
    this.lastSignInAt,
    this.metaData,
    this.bannedUntil,
    this.roles,
    this.greeting,
  });

  String? id;
  String? name;
  String? countryCode;
  String? phoneNumber;
  String? email;
  String? avatarUrl;
  String? phoneConfirmedAt;
  String? emailConfirmedAt;
  String? lastSignInAt;
  dynamic metaData;
  String? bannedUntil;
  List<String?>? roles;
  String? greeting;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        countryCode: json["country_code"],
        phoneNumber: json["phone_number"],
        email: json["email"],
        avatarUrl: json["avatar_url"],
        phoneConfirmedAt: json["phone_confirmed_at"],
        emailConfirmedAt: json["email_confirmed_at"],
        lastSignInAt: json["last_sign_in_at"],
        metaData: json["meta_data"],
        bannedUntil: json["banned_until"],
        greeting: json["greeting"],
        roles: List<String>.from(json["roles"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country_code": countryCode,
        "phone_number": phoneNumber,
        "email": email,
        "avatar_url": avatarUrl,
        "phone_confirmed_at": phoneConfirmedAt,
        "email_confirmed_at": emailConfirmedAt,
        "last_sign_in_at": lastSignInAt,
        "meta_data": metaData,
        "banned_until": bannedUntil,
        "greeting": greeting,
        "roles": List<dynamic>.from(roles!.map((x) => x)),
      };
}
