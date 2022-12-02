import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor_app/screens/home_screen/home_screen.dart';

import '../screens/sign_in_screen/screen/sign_in_screen.dart';
import '../screens/splash_screen/screen/new_splash_screen.dart';

class AppRoutes {
  AppRoutes._();

  ScrollController controller = ScrollController();
  static const initial = Routes.splashScreen;
  static final routes = [
    GetPage(
      name: Routes.splashScreen,
      page: () => const NewSplashScreen(),
    ),
    GetPage(
      name: Routes.homeScreen,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: Routes.loginScreen,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: Routes.otpScreen,
      page: () => const LoginScreen(),
    ),
  ];

  static void toNamed(page, {arguement1, arguement2}) {
    Get.toNamed(page, arguments: [
      {"argument1": arguement1, "argument2": arguement1}
    ]);
  }

  static void back() {
    Get.back();
  }

  static void offNamed(page) {
    Get.offNamed(page);
  }

  static void offAllNamed(page) {
    Get.offAllNamed(page);
  }
}

abstract class Routes {
  static const splashScreen = '/SplashScreen';
  static const homeScreen = '/HomeScreen';
  static const loginScreen = '/LoginScreen';
  static const otpScreen = '/OTPVerifyScreen';
}
