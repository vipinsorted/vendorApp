import 'dart:convert';

import 'package:dio/dio.dart' as DioApi;
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:vendor_app/network/shared_prefs.dart';

import '../logger.dart';
import '../screens/sign_in_screen/model/login_model.dart';
import '../screens/sign_in_screen/model/refresh_token_request.dart';
import 'api_end_points.dart';
import 'service_exception.dart';

class ApiClient {
  static late Dio _dio;
  static String accessToken = '';
  static String appVersion = '';

  static final LogInterceptor _logInterceptor = LogInterceptor(
    responseBody: true,
    requestHeader: true,
    responseHeader: true,
    request: true,
    error: true,
    requestBody: true,
    // logPrint: (obj) => logger.i(obj is Map ? jsonEncode(obj) : obj.toString()),
  );

  static dynamic _requestInterceptor(
      RequestOptions request, RequestInterceptorHandler handler) async {
    request.headers['Authorization'] = accessToken;
    request.headers['app_version'] = appVersion;
    return handler.next(request);
  }

  static Future<void> init() async {
    var option = BaseOptions(baseUrl: ApiEndPoints.baseUrl);
    _dio = Dio(option);
    accessToken = await SharedPref.getAccessToken() ?? '';
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    _dio.options.headers['Authorization'] = accessToken;
    _dio.options.headers['app_version'] = appVersion;
    _dio.interceptors.add(_logInterceptor);
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) => _requestInterceptor(request, handler),
        onError: (e, handler) async {
          if (e.response?.statusCode == 401) {
            refreshToken();
          } else if (e.response?.statusCode == 469) {
            SharedPref.clearTokens();
            // Get.offAll(() => const NewMobileScreen());
          }
          handler.next(e);
        },
        onResponse: (response, handler) {
          return handler.next(response); // continue
        },
      ),
    );
  }

  //get request
  static Future<dynamic> getRequest(
      {required String endpoint, Map<String, dynamic> query = const {}}) async {
    try {
      logger.d("REQUEST END POINT : $endpoint");
      DioApi.Response response =
          await _dio.get(endpoint, queryParameters: query);
      return response;
    } on DioError catch (e) {
      logger.e("DIO : : ${e.response?.data.toString()}");
      throw ServiceException(message: e.response!.statusMessage.toString());
    }
  }

  //post request
  static Future<dynamic?> postRequest(
      {required endpoint, param = const {"": ""}, Options? options}) async {
    try {
      logger.d("--------------------");
      DioApi.Response response =
          await _dio.post(endpoint, data: param, options: options);
      return response;
    } on DioError catch (e) {
      logger.e("DIO : : ${e.response?.data}");
      throw ServiceException(message: e.response!.data["message"].toString());
    }
  }

  //put request
  static Future<dynamic> putRequest(
      {required endpoint, param: const {"": ""}, id}) async {
    try {
      logger.d("--------------------");
      logger.d("REQUEST TYPE : PUT ");
      logger.d("REQUEST END POINT : $endpoint" + "/" + id.toString());
      logger.d("REQUEST DATA : $param");
      DioApi.Response response;
      if (id == null) {
        response = await _dio.put(endpoint, data: param);
      } else {
        response = await _dio.put(endpoint + "/" + id.toString(), data: param);
      }

      return response;
    } on DioError catch (e) {
      logger.e("DIO : : ${e.response?.data}");
      throw ServiceException(message: e.response!.data["message"]);
    }
  }

  //patch request
  static Future<dynamic> patchRequest(
      {required endpoint, param = const {"": ""}, id}) async {
    try {
      logger.d("--------------------");
      logger.d("REQUEST TYPE : PUT ");
      logger.d("REQUEST END POINT : $endpoint" + "/" + id.toString());
      logger.d("REQUEST DATA : $param");

      DioApi.Response response =
          await _dio.patch(endpoint + "/" + id.toString(), data: param);

      return response;
    } on DioError catch (e) {
      logger.e("DIO : : ${e.response?.data}");
      throw ServiceException(message: e.response!.data["message"]);
    }
  }

  //delete Request
  static Future<dynamic> deleteRequest({required endpoint, id}) async {
    try {
      logger.d("--------------------");
      logger.d("REQUEST TYPE : delete ");
      logger.d("REQUEST END POINT : $endpoint" + "/" + id.toString());
      DioApi.Response response;
      if (id == null) {
        response = await _dio.delete(endpoint);
      } else {
        response = await _dio.delete(endpoint + "/" + id.toString());
      }

      return response;
    } on DioError catch (e) {
      logger.e("DIO : : ${e.response?.data}");
      throw ServiceException(message: e.response!.data["message"]);
    }
  }

  static Future<LoginUserModel> refreshToken() async {
    String refreshToken = await SharedPref.getRefreshToken() ?? '';
    logger.d("Refresh Token : $refreshToken");
    DioApi.Response response = await postRequest(
      endpoint: ApiEndPoints.refresh,
      param: RefreshTokenRequest(refreshToken: refreshToken),
    );
    logger.d("response: ${response.data}");
    var user = loginUserModelFromJson(jsonEncode(response.data));
    SharedPref.setTokens(user.accessToken!, user.refreshToken!);
    SharedPref.setCurrentUser(user.user!);
    await ApiClient.init();
    return user;
  }
}
