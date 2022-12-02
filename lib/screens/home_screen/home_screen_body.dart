import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor_app/screens/home_screen/controller/inventory_controller.dart';
import 'package:vendor_app/screens/home_screen/model/inventory.dart';
import 'package:vendor_app/screens/home_screen/widget/item_tile.dart';

import '../../styles.dart';
import '../../widgets/new_custom_button.dart';

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  InventoryController _inventoryController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      padding: EdgeInsets.symmetric(
        horizontal: Insets.lg * 1.5,
        vertical: Insets.xl,
      ),
      child: ListView(
        children: [
          CategorySlider(),
          SizedBox(height: Insets.lg * 1.25,),
          ..._inventoryController.filteredItemList
              .map(
                (e) => InventoryItemTile(
              item: e,
            ),
          )
              .toList(),
        ],
      ),
    ));
  }

  Widget CategorySlider() {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            NewCustomButton(
              title: 'All',
              onTap: () =>
                  _inventoryController.setItemCategory(ItemCategory.all),
              selected:
                  _inventoryController.currentCategory == ItemCategory.all,
            ),
            SizedBox(
              width: Insets.lg,
            ),
            NewCustomButton(
              title: 'Vegetables',
              onTap: () =>
                  _inventoryController.setItemCategory(ItemCategory.vegetable),
              selected: _inventoryController.currentCategory ==
                  ItemCategory.vegetable,
            ),
            SizedBox(
              width: Insets.lg,
            ),
            NewCustomButton(
              title: 'Fruits',
              onTap: () =>
                  _inventoryController.setItemCategory(ItemCategory.fruit),
              selected:
                  _inventoryController.currentCategory == ItemCategory.fruit,
            ),
          ],
        ));
  }
}
