import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vendor_app/network/shared_prefs.dart';
import 'package:vendor_app/screens/home_screen/controller/inventory_controller.dart';
import 'package:vendor_app/screens/home_screen/home_screen_body.dart';
import 'package:vendor_app/screens/home_screen/widget/app_bar.dart';
import 'package:vendor_app/screens/home_screen/widget/side_bar.dart';
import 'package:vendor_app/screens/sign_in_screen/model/login_model.dart';
import 'package:vendor_app/themes.dart';

import '../../styles.dart';
import '../cart_screen/cart_screen.dart';
import '../cart_screen/controller/cart_controller.dart';
import '../wallet_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? activeUser;
  PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  CartController _cartController = Get.put(CartController()); //Do not remove.
  InventoryController _inventoryController = Get.put(InventoryController()); //Do not remove.
  int activePage = 0;
  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  getCurrentUser() async {
    activeUser = (await SharedPref.getCurrentUser())!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: SideBar(
          activeUser: activeUser,
        ),
        appBar: PreferredSize(
          preferredSize: Size(
            Get.width,
            Insets.xxl * 1.5,
          ),
          child: HomePageAppBar(),
        ),
        body: PageView(
          controller: _pageController,
          children: [
            HomeScreenBody(),
            WalletScreen(),
            CartScreen(),
          ],
        ),
        bottomNavigationBar: buildBottomNavigationBar(),
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: activePage,
      onTap: (selectedItem) {
        setState(() {
          setState(() {
            activePage = selectedItem;
          });
        });
        _pageController.animateToPage(
          selectedItem,
          duration: Duration(milliseconds: 200),
          curve: Curves.bounceIn,
        );
      },
      selectedLabelStyle: TextStyles.body2
          .copyWith(color: AppTheme.buttonColor, wordSpacing: 14),
      selectedItemColor: AppTheme.buttonColor,
      unselectedItemColor: AppTheme.disabledText,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      items: [
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(bottom: Insets.sm),
            child: SvgPicture.asset(
              'assets/images/home.svg',
              color:
                  activePage == 0 ? AppTheme.buttonColor : AppTheme.disabledText,
            ),
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(bottom: Insets.sm),
            child: SvgPicture.asset(
              'assets/images/home.svg',
              color:
                  activePage == 1 ? AppTheme.buttonColor : AppTheme.disabledText,
            ),
          ),
          label: "Wallet",
        ),
        BottomNavigationBarItem(
          icon: Padding(
            padding: EdgeInsets.only(bottom: Insets.sm),
            child: SvgPicture.asset(
              'assets/images/home.svg',
              color:
                  activePage == 2 ? AppTheme.buttonColor : AppTheme.disabledText,
            ),
          ),
          label: "Basket",
        ),
      ],
    );
  }
}
