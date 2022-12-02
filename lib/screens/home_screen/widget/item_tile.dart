import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    return Obx(() => Padding(
      padding: EdgeInsets.all(Insets.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            widget.item.imageUrl,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            width: Insets.xxl * 1.5,
          ),
          Container(
            margin: EdgeInsets.only(left: Insets.med),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.item.name,
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
                    SizedBox(
                      height: Insets.sm * 1.5,
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
                Row(
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
              ],
            ),
          ),
          Spacer(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: cartHasItem(),
                child: GestureDetector(
                  onTap: () =>
                      _cartController.updateItem(widget.item, false),
                  child: SizedBox(
                    width: Insets.med,
                    child: SvgPicture.asset(
                      "assets/images/minus.svg",
                      height: Insets.med,
                      width: Insets.med,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: cartHasItem(),
                child: Container(
                  width: Insets.lg * 1.5,
                  height: Insets.lg * 1.5,
                  margin: EdgeInsets.symmetric(horizontal: Insets.lg),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppTheme.borderColor,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      cartHasItem()
                          ? _cartController
                          .cartItems.value[widget.item.id]!.count
                          .toString()
                          : "",
                      style: TextStyles.body2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () =>
                    _cartController.updateItem(widget.item, true),
                child: SvgPicture.asset(
                  "assets/images/plus.svg",
                  height: Insets.med,
                ),
              ),
            ],
          ),
        ],
      ),
    ),);
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
