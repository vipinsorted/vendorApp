// To parse this JSON data, do
//
//     final numberValidation = numberValidationFromJson(jsonString);

import 'dart:convert';

NumberValidation numberValidationFromJson(String str) =>
    NumberValidation.fromJson(json.decode(str));

String numberValidationToJson(NumberValidation data) =>
    json.encode(data.toJson());

class NumberValidation {
  NumberValidation({
    this.name,
    this.isNewUser = true,
    this.success = false,
    this.message,
  });

  String? name;
  bool isNewUser;
  bool success;
  String? message;

  factory NumberValidation.fromJson(Map<String, dynamic> json) =>
      NumberValidation(
        name: json["name"],
        isNewUser: json["isNewUser"],
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "isNewUser": isNewUser,
        "success": success,
        "message": message,
      };
}
