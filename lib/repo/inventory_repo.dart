// import 'dart:convert';
// import 'package:dio/dio.dart';
//
// import '../logger.dart';
// import '../network/api_client.dart';
// import '../network/api_end_points.dart';
// import '../network/service_exception.dart';
// import '../screens/home_screen/model/store_inventory_response.dart';
//
// class InventoryRepo {
//   static Future<StoreInventoryResponse?> getInventoryList() async {
//
//     Map<String, dynamic> queryMap = {
//       "long": 77, //Coordinated to Tezerac
//       "lat": 28
//     };
//     try {
//       Response response = await ApiClient.getRequest(
//           endpoint: ApiEndPoints.storeInventory, query: queryMap);
//       if (response.statusCode == 200) {
//         logger.d("Response : ${response.data}");
//       } else {
//         logger.d("Response is null : ${response.data}");
//       }
//       var json = jsonEncode(response.data);
//
//       logger.d("Final  : $json");
//       return storeInventoryFromJson(json);
//     } on ServiceException catch (e) {
//       throw RepoServiceException(message: e.message);
//     }
//   }
// }
