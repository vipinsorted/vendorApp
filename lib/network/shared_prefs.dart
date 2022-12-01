// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../screens/sign_in_screen/model/login_model.dart';


class SharedPref {
  static const String ACCESS_TOKEN = 'ACCESS_TOKEN';
  static const String COUNT_SLIDE_TO_PICK = 'Slide_To_Pick';
  static const String COUNT_DOWN_ARROW = 'count_down_arrow';
  static const String REFRESH_TOKEN = 'REFRESH_TOKEN';
  static const String CLIENT_ID = 'CLIENT_ID';
  static const String CLIENT_SECRET = 'CLIENT_SECRET';
  static const String ADDRESS = 'address_cart';
  static const String CURRENT_USER = 'CURRENT_USER';
  static const String LOCATION_DETAILS = 'LOCATION_DETAILS';
  static const String PLACE_ID = 'PLACE_ID';
  static const String baseUrl = 'base_url';
  static const String storyBaseUrl = 'story_base_url';
  static const String ADDRESS_DETAIL = 'ADDRESS_DETAIL';
  static const String CURRENT_ADDRESS_DETAIL = 'CURRENT_ADDRESS_DETAIL_1';
  static const String EDIT_ADDRESS_DETAIL = 'EDIT_ADDRESS_DETAIL';
  static const String CALL_TO_ORDER_NUMBER = 'CALL_TO_ORDER_NUMBER';
  static const String WHATSAPP_NUMBER = 'WHATSAPP_NUMBER';
  static const String HELP_NUMBER = 'HELP_NUMBER';
  static const String SORTING_DATA = 'SORTING_DATA';
  static const String TERMS_AND_CONDITION = 'Terms_and_Conditions';
  static const String PRIVACY_POLICY = 'Privacy_Policy';
  static const String GREETING = 'Greeting';
  static const String CHECK_LOGIN = 'Check_login';
  static const String ROUTES = 'ROUTES';
  static const String IS_FIREBASE_ENABLED = 'IS_FIREBASE_ENABLED';
  static const String LOCATION_PERMISSION_COUNT = 'LOCATION_PERMISSION_COUNT';
  static const String MIN_IMAGE_URL = 'MIN_IMAGE_URL';
  static const String orderId = 'order_id';

  static Future<SharedPreferences> _getPref() async {
    return await SharedPreferences.getInstance();
  }

  static Future<void> setTokens(String accessToken, String refreshToken) async {
    final pref = await _getPref();
    await pref.setString(ACCESS_TOKEN, accessToken);
    await pref.setString(REFRESH_TOKEN, refreshToken);
  }

  static Future<void> setCurrentOrderId(String OrderId) async {
    final pref = await _getPref();
    await pref.setString(orderId, OrderId);
  }

  static Future<void> setCountSlideToPick(int count) async {
    final pref = await _getPref();
    await pref.setInt(COUNT_SLIDE_TO_PICK, count);
  }

  static Future<void> clearTokens() async {
    final pref = await _getPref();
    await pref.remove(ACCESS_TOKEN);
    await pref.remove(REFRESH_TOKEN);
  }

  static Future<void> clearAddressForCart() async {
    final pref = await _getPref();
    await pref.remove(ADDRESS);
  }

  static Future<void> clearSharedPref() async {
    final pref = await _getPref();
    await pref.clear();
  }

  static Future<String?> getAccessToken() async {
    final pref = await _getPref();
    return pref.getString(ACCESS_TOKEN);
  }

  static Future<String?> getRefreshToken() async {
    final pref = await _getPref();
    return pref.getString(REFRESH_TOKEN);
  }

  static Future<String?> getBaseUrl() async {
    final pref = await _getPref();
    return pref.getString(baseUrl);
  }

  static Future<String?> getStoryUrl() async {
    final pref = await _getPref();
    return pref.getString(storyBaseUrl);
  }

  static Future<String?> getTermsAndConditionUrl() async {
    final pref = await _getPref();
    return pref.getString(TERMS_AND_CONDITION);
  }

  static Future<String?> getPrivacyPolicyUrl() async {
    final pref = await _getPref();
    return pref.getString(PRIVACY_POLICY);
  }

  static Future<String?> getCallToOrderNumber() async {
    final pref = await _getPref();
    return pref.getString(CALL_TO_ORDER_NUMBER)!;
  }

  static Future<String?> getWhatsAppNumber() async {
    final pref = await _getPref();
    return pref.getString(WHATSAPP_NUMBER);
  }

  static Future<String?> getHelpNumber() async {
    final pref = await _getPref();
    return pref.getString(HELP_NUMBER);
  }

  static Future<String?> getMinImageURlUrl() async {
    final pref = await _getPref();
    return pref.getString(MIN_IMAGE_URL);
  }

  static Future<String?> getCurrentOrderId() async {
    final pref = await _getPref();
    return pref.getString(orderId);
  }

  static Future<int?> getCountSlideToPick() async {
    final pref = await _getPref();
    return pref.getInt(COUNT_SLIDE_TO_PICK);
  }

  static Future<String?> getStringWithKey(String key) async {
    final pref = await _getPref();
    return pref.getString(key);
  }

  static Future<void> setStringWithKey(String key, String value) async {
    final pref = await _getPref();
    await pref.setString(key, value);
  }

  static Future<void> setBoolWithKey(String key, bool value) async {
    final pref = await _getPref();
    await pref.setBool(key, value);
  }

  static Future<bool?> getBoolWithKey(String key) async {
    final pref = await _getPref();
    return pref.getBool(key);
  }

  static Future<void> setBoolVal(isLogin) async {
    final pref = await _getPref();
    await pref.setBool(CHECK_LOGIN, isLogin);
  }

  static Future<bool?> getBoolVal() async {
    final pref = await _getPref();
    return pref.getBool(CHECK_LOGIN);
  }

  static Future<void> setRoutes(String routes) async {
    final pref = await _getPref();
    await pref.setString(ROUTES, routes);
  }

  static Future<String?> getRoutes() async {
    final pref = await _getPref();
    return pref.getString(ROUTES);
  }

  static Future<void> setPermissionCount(int value) async {
    final pref = await _getPref();
    await pref.setInt(LOCATION_PERMISSION_COUNT, value);
  }

  static Future<int> getPermissionCount() async {
    final pref = await _getPref();
    int? count = pref.getInt(LOCATION_PERMISSION_COUNT);
    if (count == null || count == -1 || count == 0) {
      return 0;
    } else {
      return count;
    }
  }

  static Future<void> setCurrentUser(User user) async {
    final pref = await _getPref();
    await pref.setString(CURRENT_USER, json.encode(user));
  }

  static Future<User?> getCurrentUser() async {
    final pref = await _getPref();
    if (pref.getString(CURRENT_USER) == null ||
        !pref.containsKey(CURRENT_USER)) {
      return null;
    }
    return User.fromJson(await json.decode(pref.getString(CURRENT_USER)!));
  }
}
