import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../styles.dart';
import '../themes.dart';

class CheckLoginBox {
  static getPopup({
    String? heading,
    String? label,
    String? buttonNameAllow,
    String? buttonNameDeny,
    VoidCallback? allowTap,
    VoidCallback? denyTap,
    VoidCallback? onDeclinePermission,
    Color titleColor = AppTheme.elSalva,
    Color allowButtonColor = AppTheme.buttonColor,
    Color denyButtonColor = AppTheme.errorRed,
  }) {
    Get.defaultDialog(

        barrierDismissible: false,
        title: heading!,
        titleStyle: TextStyles.title2.copyWith(
            fontSize: 24, fontWeight: FontWeight.w700, color: titleColor),
        titlePadding: EdgeInsets.only(
            left: Insets.med,
            right: Insets.med,
            top: Insets.lg,
            bottom: Insets.med),
        // contentPadding: EdgeInsets.zero.copyWith(bottom: Insets.med),
        content: Container(
          decoration: BoxDecoration(borderRadius: Corners.xlBorder * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: Insets.xl, right: Insets.xl, bottom: Insets.lg + 6),
                child: Text(label!, textAlign: TextAlign.center,),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  customButton(
                      onTap: denyTap!,
                      text: buttonNameDeny!,
                      textColor: denyButtonColor),
                  customButton(
                      onTap: allowTap!,
                      text: buttonNameAllow!,
                      textColor: allowButtonColor),
                ],
              ),
              SizedBox(height: Insets.sm)
            ],
          ),
        ),
        onWillPop: () async {
          if (onDeclinePermission != null) {
            onDeclinePermission();
            return true;
          } else if (denyTap != null) {
            denyTap();
          }
          return true;
        });
  }

  static Widget customButton(
      {required VoidCallback onTap,
      required String text,
      required Color textColor}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(
            top: Insets.sm,
            right: Insets.sm,
            bottom: Insets.sm,
            left: Insets.sm),
        child: Text(
          text,
          style: TextStyles.primary.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
