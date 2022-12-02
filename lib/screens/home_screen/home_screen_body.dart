import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Insets.lg * 1.5, vertical: Insets.xl),
      child: ListView(
        children: [
          CategorySlider(),
          ...(List<InventoryItem>.filled(
                  6,
                  InventoryItem.fromJson({
                    "id": 1234,
                    "category": "Vegetable",
                    "quantity_per_crate": 10,
                    "suffix": "KILOGRAM",
                    "price_per_crate": 220.00,
                    "item_name": "Baigan",
                    "image_url":
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/62/Solid_red.svg/512px-Solid_red.svg.png?20150316143248",
                  }))
              .map(
                (e) => InventoryItemTile(
                  item: e,
                ),
              )
              .toList()),
        ],
      ),
    );
  }

  Widget CategorySlider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        NewCustomButton(
          title: 'All',
          onTap: () {},
          selected: true,
        ),
        SizedBox(
          width: Insets.lg,
        ),
        NewCustomButton(
          title: 'Vegetables',
          onTap: () {},
        ),
        SizedBox(
          width: Insets.lg,
        ),
        NewCustomButton(
          title: 'Fruits',
          onTap: () {},
        ),
      ],
    );
  }
}