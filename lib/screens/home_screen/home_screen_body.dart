import 'package:flutter/material.dart';
import 'package:vendor_app/screens/home_screen/model/inventory.dart';
import 'package:vendor_app/widgets/custom_button.dart';

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
      child: SingleChildScrollView(
        child: Column(
          children: [
            CategorySlider(),
            ...(List<InventoryItem>.filled(
                    6,
                    InventoryItem.fromJson({
                      "id": 1234,
                    }))
                .map(
                  (e) => ListTile(
                    title: Text("Sample"),
                  ),
                )
                .toList()),
          ],
        ),
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
