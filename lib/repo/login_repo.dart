import 'dart:convert';

import 'package:dio/dio.dart';

import '../logger.dart';
import '../network/api_client.dart';
import '../network/api_end_points.dart';
import '../network/service_exception.dart';
import '../network/shared_prefs.dart';
import '../screens/number_validation_screen/model/number_validation_model.dart';
import '../screens/sign_in_screen/model/login_model.dart';

class LoginRepo {
  static Future<LoginUserModel> createUser() async {
    try {
      Response response = await ApiClient.postRequest(
          endpoint: ApiEndPoints.createUser, param: {});
      logger.d("create user response: ${response.data}");
      var user = loginUserModelFromJson(jsonEncode(response.data));
      SharedPref.setTokens(user.accessToken!, user.refreshToken!);
      SharedPref.setCurrentUser(user.user!);
      // MixPanelWrapper.setUserProperties();
      await ApiClient.init();
      return user;
    } on ServiceException catch (e) {
      throw RepoServiceException(message: e.message);
    }
  }

  static Future<NumberValidation?> numberValidation(String? number) async {
    logger.d("Login request $number");
    Response response = await ApiClient.postRequest(
        endpoint: ApiEndPoints.sendOtp,
        param: {
          "phone_number": number,
          'country_code': '+91',
        });
    return numberValidationFromJson(jsonEncode(response.data));
  }

  static Future<LoginUserModel?> otpVerify(String? otp, String? number) async {
    Response response = await ApiClient.postRequest(
        endpoint: ApiEndPoints.verifyOtp,
        param: {
          "otp": otp,
          "phone_number": number,
        });
    var user = loginUserModelFromJson(jsonEncode(response.data));
    SharedPref.setTokens(user.accessToken!, user.refreshToken!);
    SharedPref.setCurrentUser(user.user!);
    await ApiClient.init();
    return user;
  }

  // static Future<LogoutResponse?> logOut() async {
  //   try {
  //     String? refreshToken = await SharedPref.getRefreshToken();
  //     Response response = await ApiClient.postRequest(
  //         endpoint: ApiEndPoints.logOut,
  //         param: {"refresh_token": refreshToken});
  //     if (response.statusCode == 201) {
  //       logger.d("logOut : ${response.data}");
  //       var json = jsonEncode(response.data);
  //       return logoutResponseFromJson(json);
  //     } else {
  //       logger.d("logOut Response is null : ${response.data}");
  //     }
  //   } on ServiceException catch (e) {
  //     throw RepoServiceException(message: e.message);
  //   }
  // }
  //
  // static Future<LogoutResponse?> deleteAccount() async {
  //   try {
  //     Response response =
  //         await ApiClient.deleteRequest(endpoint: ApiEndPoints.deleteAccount);
  //     if (response.statusCode == 200) {
  //       logger.d("deleteAccount : ${response.data}");
  //       var json = jsonEncode(response.data);
  //       return logoutResponseFromJson(json);
  //     } else {
  //       logger.d("deleteAccount Response is null : ${response.data}");
  //     }
  //   } on ServiceException catch (e) {
  //     throw RepoServiceException(message: e.message);
  //   }
  // }
}
