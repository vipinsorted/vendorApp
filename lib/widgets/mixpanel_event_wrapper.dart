// import 'dart:async';
//
// import '../main.dart';
// import '../network/shared_prefs.dart';
// import '../screens/sign_in_screen/model/login_model.dart';
//
// class EventMixPanel {
//   EventMixPanel({
//     this.eventName,
//     required this.eventProperties,
//   });
//
//   String? eventName;
//   Map<String, dynamic> eventProperties;
// }
//
// class MixPanelWrapper {
//   MixPanelWrapper._();
//   final _user$ = StreamController<String>.broadcast();
//
//   static track(String eventName, Map<String, dynamic> properties) async {
//     User? user = await SharedPref.getCurrentUser();
//     String? userPhoneNumber = user?.phoneNumber;
//     String? accessToken = await SharedPref.getAccessToken();
//     mixpanel.registerSuperProperties(
//         {"user": "$userPhoneNumber", "Token": "$accessToken"});
//     properties["token"] = accessToken;
//     mixpanel.track(eventName, properties: properties);
//   }
//
//   static timeEvent(String eventName) async {
//     mixpanel.timeEvent(eventName);
//   }
//
//   static setUserProperties({MapEntryKey, MapEntryValue}) async {
//     //after login create a distinct id and property of user
//     String distinctId = await mixpanel.getDistinctId();
//     User? user = await SharedPref.getCurrentUser();
//     String? username = user?.name;
//     mixpanel.identify(distinctId);
//     mixpanel.alias(username ?? username!, distinctId);
//     //mixpanel.getPeople().set(MapEntryKey, MapEntryValue);
//   }
// }
