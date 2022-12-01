import 'dart:convert';

DeviceDetailsRequest deviceDetailsRequestFromJson(String str) =>
    DeviceDetailsRequest.fromJson(json.decode(str));

String deviceDetailsRequestToJson(DeviceDetailsRequest data) =>
    json.encode(data.toJson());

class DeviceDetailsRequest {
  DeviceDetailsRequest({
    this.userId,
    this.deviceId,
    this.macAddress,
    this.manufacturer,
    this.model,
    this.os,
    this.appVersion,
  });

  String? userId;
  String? deviceId;
  String? macAddress;
  String? manufacturer;
  String? model;
  String? os;
  String? appVersion;

  factory DeviceDetailsRequest.fromJson(Map<String, dynamic> json) =>
      DeviceDetailsRequest(
        userId: json["user_id"],
        deviceId: json["device_id"],
        macAddress: json["mac_address"],
        manufacturer: json["manufacturer"],
        model: json["model"],
        os: json["os"],
        appVersion: json["app_version"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "device_id": deviceId,
        "mac_address": macAddress,
        "manufacturer": manufacturer,
        "model": model,
        "os": os,
        "app_version": appVersion,
      };
}
