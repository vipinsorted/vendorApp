import 'dart:convert';

NameUpdateRequestModel nameUpdateRequestModelFromJson(String str) =>
    NameUpdateRequestModel.fromJson(json.decode(str));

String nameUpdateRequestModelToJson(NameUpdateRequestModel data) =>
    json.encode(data.toJson());

class NameUpdateRequestModel {
  NameUpdateRequestModel({
    this.name,
    this.greeting,
  });
  String? name;
  String? greeting;

  factory NameUpdateRequestModel.fromJson(Map<String, dynamic> json) =>
      NameUpdateRequestModel(
        name: json["name"],
        greeting: json["greeting"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "greeting": greeting,
      };
}
