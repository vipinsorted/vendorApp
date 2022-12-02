// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'package:get/get.dart';

import '../../home_screen/model/inventory.dart';

class CartItem {
  CartItem({
    required this.item,
    required this.count,
  });
  final InventoryItem item;
  final int count;
}

class CartController extends GetxController {
  Map<int, CartItem> a = {};
  Rx<Map<int, CartItem>> cartItems = Rx<Map<int, CartItem>>({});

  updateItem(InventoryItem item, bool addItem) {
    if (cartItems.value[item.id]?.count == 1 &&
        !addItem) {
      cartItems.value.remove(item.id);
    } else {
      cartItems.value.update(
        item.id,
        (value) => CartItem(
          item: item,
          count: addItem ? value.count + 1 : value.count - 1,
        ),
        ifAbsent: () => CartItem(item: item, count: 1),
      );
    }
  }
}
