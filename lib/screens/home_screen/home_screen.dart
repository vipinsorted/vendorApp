import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vendor_app/network/shared_prefs.dart';
import 'package:vendor_app/screens/home_screen/home_screen_body.dart';
import 'package:vendor_app/screens/home_screen/widget/app_bar.dart';
import 'package:vendor_app/screens/home_screen/widget/side_bar.dart';
import 'package:vendor_app/screens/sign_in_screen/model/login_model.dart';

import '../../styles.dart';
import '../../themes.dart';
import '../cart_screen.dart';
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
      currentIndex: 1,
      onTap: (selectedItem) {},
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Wallet",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Basket",
        ),
      ],
    );
  }
}
