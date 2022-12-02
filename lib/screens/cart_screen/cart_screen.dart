import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor_app/screens/cart_screen/controller/cart_controller.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartController _cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        child: Column(
          children: _cartController.cartItems.value.entries
              .map((e) => Text("${e.value.count} : ${e.value.item.itemName}"))
              .toList(),
        ),
      ),
    );
  }
}
