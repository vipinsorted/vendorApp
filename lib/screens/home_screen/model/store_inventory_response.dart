// import 'dart:convert';
//
// import 'inventory.dart';
// import 'store.dart';
// import 'tags.dart';
//
// StoreInventoryResponse storeInventoryFromJson(String str) =>
//     StoreInventoryResponse.fromJson(json.decode(str));
//
// String storeInventoryToJson(StoreInventoryResponse data) =>
//     json.encode(data.toJson());
//
// class StoreInventoryResponse {
//   StoreInventoryResponse({
//     this.store,
//     this.inventory,
//     this.sortedInventory,
//     this.inventoryTagsImage,
//   });
//
//   Store? store;
//   List<Inventory>? inventory;
//   Map<String, dynamic>? sortedInventory;
//   List<Tags>? inventoryTagsImage;
//
//   factory StoreInventoryResponse.fromJson(Map<String, dynamic> json) =>
//       StoreInventoryResponse(
//         store: Store.fromJson(json["store"]),
//         inventory: json['inventory'] != null
//             ? List<Inventory>.from(
//                 json["inventory"].map((x) => Inventory.fromJson(x ?? {})))
//             : [],
//         sortedInventory: json['sorted_inventory'] != null
//             ? Map.from(json["sorted_inventory"])
//                 .map((k, v) => MapEntry<String, dynamic>(k, v))
//             : null,
//         inventoryTagsImage: json['inventory_tags_image'] != null
//             ? List<Tags>.from(
//                 json["inventory_tags_image"].map((x) => Tags.fromJson(x ?? {})))
//             : [],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "store": store!.toJson(),
//         "inventory": List<dynamic>.from(inventory!.map((x) => x.toJson())),
//         "sorted_inventory": Map.from(sortedInventory!)
//             .map((k, v) => MapEntry<String, dynamic>(k, v)),
//         "inventory_tags_image":
//             List<dynamic>.from(inventoryTagsImage!.map((x) => x.toJson())),
//       };
// }
