import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../styles.dart';
import '../../../themes.dart';
import '../../cart_screen/controller/cart_controller.dart';
import '../model/inventory.dart';

class InventoryItemTile extends StatefulWidget {
  InventoryItemTile({
    Key? key,
    required this.item,
  }) : super(key: key);
  final InventoryItem item;

  @override
  State<InventoryItemTile> createState() => _InventoryItemTileState();
}

class _InventoryItemTileState extends State<InventoryItemTile> {
  CartController _cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListTile(
          horizontalTitleGap: 8,
          contentPadding: EdgeInsets.all(Insets.lg),
          leading: Image.network(
            widget.item.imageUrl,
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
                      widget.item.itemName,
                      style: TextStyles.body3.copyWith(
                        fontSize: FontSizes.s14,
                      ),
                    ),
                    SizedBox(
                      width: Insets.med,
                    ),
                    Text(
                      "(${widget.item.quantityPerCrate} Kg)",
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
                  "1 Kilogram - Rs ${widget.item.pricePerCrate / widget.item.quantityPerCrate}",
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
                "Rs ${widget.item.pricePerCrate}",
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
              Visibility(
                visible: cartHasItem(),
                child: GestureDetector(
                  onTap: () => _cartController.updateItem(widget.item, false),
                  child: Icon(Icons.remove),
                ),
              ),
              SizedBox(
                width: Insets.lg,
                child: Center(
                  child: Text(cartHasItem()
                      ? _cartController.cartItems.value[widget.item.id]?.count
                              .toString() ??
                          "NaN"
                      : ""),
                ),
              ),
              GestureDetector(
                  onTap: () => _cartController.updateItem(widget.item, true),
                  child: Icon(Icons.add)),
            ],
          ),
          // trailing: ,
        ));
  }

  bool cartHasItem() =>
      _cartController.cartItems.value.containsKey(widget.item.id);

  String getItemCount() {
    if (cartHasItem()) {
      return _cartController.cartItems.value[widget.item.id]?.count
              .toString() ??
          "NaN";
    }
    return "";
  }
}
