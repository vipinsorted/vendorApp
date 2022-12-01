import 'dart:convert';

import 'package:dio/dio.dart';

import '../logger.dart';
import '../network/api_client.dart';
import '../network/api_end_points.dart';
import '../network/service_exception.dart';
import '../network/shared_prefs.dart';
import '../screens/sign_in_screen/model/device_details.dart';
import '../screens/sign_in_screen/model/login_model.dart';
import '../screens/splash_screen/model/init_config_response.dart';

class ConfigRepo {
  static Future<int?> updateDeviceDetails(
      DeviceDetailsRequest deviceDetailsRequest) async {
    try {
      User? user = await SharedPref.getCurrentUser();
      if (user != null) {

        Response response = await ApiClient.postRequest(
            endpoint:
                "${ApiEndPoints.profileUpdate}/${user.id!}${ApiEndPoints.deviceDetails}",
            param: deviceDetailsRequest);
        if (response.statusCode == 201) {
          logger.d("Response : ${response.data}");
        } else {
          logger.d("Response is null : ${response.data}");
        }
        return 1;
      }
    } on ServiceException catch (e) {
      throw RepoServiceException(message: e.message);
    }
  }

  static Future<InitConfigResponse?> getInitConfig() async {
    try {
      await ApiClient.init();
      Response response =
          await ApiClient.getRequest(endpoint: ApiEndPoints.initConfig);
      if (response.statusCode == 200) {
        logger.d("Response : ${response.data}");
        var json = jsonEncode(response.data);
        return initConfigResponseFromJson(json);
      } else {
        logger.e("Response is null : ${response.data}");
      }
      return null;
    } on ServiceException catch (e) {
      throw RepoServiceException(message: e.message);
    }
  }
}
