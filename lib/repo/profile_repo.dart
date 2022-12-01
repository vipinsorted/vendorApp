import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../logger.dart';
import '../network/api_client.dart';
import '../network/api_end_points.dart';
import '../network/service_exception.dart';
import '../network/shared_prefs.dart';
import '../screens/name/model/name_update_request.dart';
import '../screens/sign_in_screen/model/login_model.dart';

class ProfileRepo {
  static Future<User?> updateProfile(
      NameUpdateRequestModel nameUpdateRequestModel) async {
    try {
      User? user = await SharedPref.getCurrentUser();
      if (user != null) {
        Response response = await ApiClient.patchRequest(
            endpoint: ApiEndPoints.profileUpdate,
            id: user.id!,
            param: nameUpdateRequestModel);
        logger.d("response: ${response.data}");
        var finalUser = userFromJson(jsonEncode(response.data));
        SharedPref.setCurrentUser(finalUser);
        return finalUser;
      } else {
        return null;
      }
    } on ServiceException catch (e) {
      throw RepoServiceException(message: e.message);
    }
  }

  // Future<void> updateFCM(String token) async {
  //   print('Set products status');
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // String token = prefs.getString("token");
  //   // FirebaseRequest firebaseRequest = FirebaseRequest(
  //   //     name: prefs.getString('CURRENT_USER')!, cmFirebaseToken: token);
  //
  //   // print('Set token status : ${firebaseRequest.cmFirebaseToken}');
  //   // print('Set shdjsdg :  + ${firebaseRequest.toJson()}');
  // }
}
