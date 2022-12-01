
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../styles.dart';
import '../../../themes.dart';
import '../../sign_in_screen/model/login_model.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key? key, required this.activeUser}) : super(key: key);
  final User activeUser;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: Get.width * .56,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          vertical: Insets.xxl,
          horizontal: Insets.lg * 1.5,
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: Insets.lg * 1.5,
                  ),
                  SizedBox(
                    height: Insets.lg * 1.125,
                  ),
                  Text(
                    activeUser.name ?? "",
                    style: TextStyles.body2.copyWith(
                      fontSize: FontSizes.s16,
                    ),
                  ),
                  SizedBox(
                    height: Insets.xs,
                  ),
                  Text(
                    activeUser.phoneNumber ?? "",
                    style: TextStyles.body2.copyWith(
                      color: AppTheme.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                },
                child: Padding(
                  padding: EdgeInsets.only(top: Insets.sm),
                  child: Icon(
                    Icons.keyboard_double_arrow_left_sharp,
                    size: Insets.lg * 1.5,
                  ),
                ),
              ),
            ],
          ),
          Container(
            child: Divider(
              color: AppTheme.grey,
            ),
          ),
          CustomDrawerItem(
            iconPath: "assets/images/home.svg",
            title: "Home",
            onTap: () {},
          ),
          CustomDrawerItem(
            iconPath: "assets/images/my_orders.svg",
            title: "My Orders",
            onTap: () {},
          ),
          CustomDrawerItem(
            iconPath: "assets/images/my_invoice.svg",
            title: "My Invoice",
            onTap: () {},
          ),
          CustomDrawerItem(
            iconPath: "assets/images/home.svg",
            title: "My Account",
            onTap: () {},
          ),
          CustomDrawerItem(
            iconPath: "assets/images/home.svg",
            title: "Help",
            onTap: () {},
          ),
          CustomDrawerItem(
            iconPath: "assets/images/home.svg",
            title: "Settings",
            onTap: () {},
          ),
        ],
      ),
    );
  }

  CustomDrawerItem({
    required String iconPath,
    required String title,
    required VoidCallback onTap,
  }) {
    return TextButton(
      onPressed: onTap,
      style: ButtonStyle(
        padding: MaterialStateProperty.resolveWith(
              (states) => EdgeInsets.symmetric(
            vertical: Insets.med,
            horizontal: 0,
          ),
        ),
        overlayColor: MaterialStateColor.resolveWith(
              (states) => Colors.transparent,
        ),
      ),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: Insets.xxl,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  SvgPicture.asset(
                    iconPath,
                    height: Insets.lg,
                    width: Insets.lg,
                    fit: BoxFit.fitHeight,
                  ),
                ],
              ),
            ),
            Text(
              title,
              style: TextStyles.body2.copyWith(
                fontSize: FontSizes.s16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
