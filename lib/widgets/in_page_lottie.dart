import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../styles.dart';
import '../themes.dart';

class InPageLoadingLottie extends StatelessWidget {
  const InPageLoadingLottie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Get.size.height,
        decoration: const BoxDecoration(
          color: AppTheme.white,
        ),
        child: Center(
          child: Lottie.asset("assets/images/loading.json",
              repeat: true,
              width: Insets.offsetMed * 2,
              height: Insets.offsetMed * 2),
        ));
  }
}
