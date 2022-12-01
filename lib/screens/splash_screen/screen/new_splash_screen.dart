import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:vendor_app/routes/app_routes.dart';

import '../../../network/shared_prefs.dart';
import '../../sign_in_screen/controller/signup_controller.dart';
import '../../sign_in_screen/model/login_model.dart';
import '../controller/config_controller.dart';

class NewSplashScreen extends StatefulWidget {
  const NewSplashScreen({Key? key}) : super(key: key);

  @override
  State<NewSplashScreen> createState() => _NewSplashScreenState();
}

class _NewSplashScreenState extends State<NewSplashScreen> {
  String? phoneNumber = '';
  RxBool isLoading = true.obs;

  splashScreenTimer() async {
    User? user = await SharedPref.getCurrentUser();
    print("Ashish ${user?.toJson()}");
    if (user != null && user.phoneNumber != null) {
      phoneNumber = user.phoneNumber;
      Get.toNamed(Routes.homeScreen);
    } else {
      Get.toNamed(Routes.loginScreen);
    }
  }

  @override
  void initState() {
    // createUser();
    splashScreenTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Lottie.asset(
          "assets/images/splash_lottie.json",
          repeat: true,
          height: Get.size.height,
          width: Get.size.width,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
