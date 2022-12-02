import 'package:get/get.dart';

import '../model/inventory.dart';

class InventoryController extends GetxController {
  Rx<ItemCategory> currentCategory = ItemCategory.all.obs;
  Rx<String> searchQuery = "".obs;
  RxList<InventoryItem> allItemsList = List<InventoryItem>.generate(
    12,
    (index) => InventoryItem.fromJson(
      {
        "id": index,
        "category": "Vegetable",
        "quantity_per_crate": 10,
        "suffix": "KILOGRAM",
        "price_per_crate": 220.00,
        "item_name": "Apple $index",
        "image_url":
            "https://www.bigbasket.com/media/uploads/p/xxl/40033821-2_1-fresho-apple-kinnaur.jpg",
      },
    ),
  ).obs;
  RxList<InventoryItem> filteredItemList = List<InventoryItem>.empty().obs;

  @override
  onInit() {
    updateInventoryList();
    super.onInit();
  }

  updateInventoryList() async {
    filteredItemList.value = allItemsList
        .where(
          (item) =>
              currentCategory == ItemCategory.all ||
              currentCategory == item.category,
        )
        .where(
          (element) =>
              searchQuery.isEmpty ||
              element.name.toLowerCase().contains(searchQuery.toLowerCase()),
        )
        .toList();
  }

  setItemCategory(ItemCategory category) {
    currentCategory.value = category;
    updateInventoryList();
  }
}
