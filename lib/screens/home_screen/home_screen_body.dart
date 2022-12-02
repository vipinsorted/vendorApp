import 'package:flutter/material.dart';
import 'package:vendor_app/screens/home_screen/model/inventory.dart';

import '../../styles.dart';
import '../../themes.dart';
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
                  e: e,
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

class InventoryItemTile extends StatelessWidget {
  const InventoryItemTile({
    Key? key,
    required this.e,
  }) : super(key: key);
  final InventoryItem e;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 8,
      contentPadding: EdgeInsets.all(Insets.lg),
      leading: Image.network(
        e.imageUrl,
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
        width: Insets.xxl * 1.5,
      ),
      title: Padding(
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  e.itemName,
                  style: TextStyles.body3.copyWith(
                    fontSize: FontSizes.s14,
                  ),
                ),
                SizedBox(
                  width: Insets.med,
                ),
                Text(
                  "(${e.quantityPerCrate} Kg)",
                  style: TextStyles.body2.copyWith(
                    color: AppTheme.grey,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Insets.xs * 1.5,
            ),
            Text(
              "1 Kilogram - Rs ${e.pricePerCrate / e.quantityPerCrate}",
              style: TextStyles.body3.copyWith(
                fontSize: FontSizes.s11,
                color: AppTheme.grey,
              ),
            ),
            SizedBox(
              height: Insets.med,
            ),
          ],
        ),
      ),
      subtitle: Row(
        children: [
          Text(
            "Rs ${e.pricePerCrate}",
            style: TextStyles.body1.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            "/crate",
            style: TextStyles.body1,
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(onTap: () {}, child: Icon(Icons.add)),
          Text(1.toString()),
          GestureDetector(onTap: () {}, child: Icon(Icons.add)),
        ],
      ),
      // trailing: ,
    );
  }
}
