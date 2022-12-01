import 'dart:convert';

InitConfigResponse initConfigResponseFromJson(String str) =>
    InitConfigResponse.fromJson(json.decode(str));

String initConfigResponseToJson(InitConfigResponse data) =>
    json.encode(data.toJson());

class InitConfigResponse {
  InitConfigResponse({
    this.name,
    this.config,
    this.serverTS,
  });

  String? name;
  Config? config;
  String? serverTS;

  factory InitConfigResponse.fromJson(Map<String, dynamic> json) =>
      InitConfigResponse(
        name: json["name"],
        config: Config.fromJson(json["config"]),
        serverTS: json["serverTS"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "config": config!.toJson(),
        "serverTS": serverTS,
      };
}

class Config {
  Config(
      {this.cdnBaseUrl,
      this.storyBaseUrl,
      this.callToOrderNumber,
      this.whatsAppNumber,
      this.helpNumber,
      this.termsAndConditions,
      this.privacyPolicy,
      this.homePageSortList,
      this.isFirebaseEnabled = false,
      this.minImageUrl});

  String? cdnBaseUrl;
  String? storyBaseUrl;
  String? callToOrderNumber;
  String? whatsAppNumber;
  String? helpNumber;
  String? termsAndConditions;
  String? privacyPolicy;
  List<String>? homePageSortList;
  bool? isFirebaseEnabled;
  String? minImageUrl;

  factory Config.fromJson(Map<String, dynamic> json) => Config(
        cdnBaseUrl: json["CDN_BASE_URL"],
        storyBaseUrl: json["STORY_BASE_URL"],
        callToOrderNumber: json["CALL_TO_ORDER_NUMBER"],
        whatsAppNumber: json["WHATSAPP_NUMBER"],
        helpNumber: json["HELP_NUMBER"],
        termsAndConditions: json["Terms_and_Conditions"],
        privacyPolicy: json["Privacy_Policy"],
        homePageSortList:
            List<String>.from(json["HOME_PAGE_SORT_LIST"].map((x) => x)),
        isFirebaseEnabled: json["IS_FIREBASE_ENABLED"],
        minImageUrl: json["MIN_IMAGE_URL"],
      );

  Map<String, dynamic> toJson() => {
        "CDN_BASE_URL": cdnBaseUrl,
        "STORY_BASE_URL": storyBaseUrl,
        "CALL_TO_ORDER_NUMBER": callToOrderNumber,
        "WHATSAPP_NUMBER": whatsAppNumber,
        "HELP_NUMBER": helpNumber,
        "Terms_and_Conditions": termsAndConditions,
        "Privacy_Policy": privacyPolicy,
        "HOME_PAGE_SORT_LIST":
            List<dynamic>.from(homePageSortList!.map((x) => x)),
        "IS_FIREBASE_ENABLED": isFirebaseEnabled,
        "MIN_IMAGE_URL": minImageUrl,
      };
}
