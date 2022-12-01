import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../themes.dart';

class LoadingLottie {
  static loadingLottie(BuildContext context) {
    Get.dialog(
        transitionCurve: Curves.easeInOut,
        barrierDismissible: true,
        barrierColor: Colors.transparent,
        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
      return SimpleDialog(
        titlePadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        insetPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        backgroundColor: AppTheme.white,
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: AppTheme.white,
              ),
              child: Center(
                child: Lottie.asset("assets/images/loading.json",
                    repeat: true,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height),
              ))
        ],
      );
    }));
  }
}
