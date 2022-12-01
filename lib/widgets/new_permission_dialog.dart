import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../styles.dart';
import '../themes.dart';

class NewPermissionPopup {
  static getPopup(
      {String? title,
        String? heading,
        String? image,
        String? label,
        IconData? buttonIconAllow,
        IconData? buttonIconDeny,
        String? buttonIconAllowImage,
        String? buttonIconDenyImage,
        String? buttonNameAllow,
        String? buttonNameDeny,
        VoidCallback? allowTap,
        VoidCallback? denyTap,
        VoidCallback? onDeclinePermission}) {
    Get.defaultDialog(
        barrierDismissible: false,
        title: title!,
        titleStyle: TextStyles.title2.copyWith(fontSize: 2),
        titlePadding: EdgeInsets.zero,
        content: Container(
          decoration: BoxDecoration(borderRadius: Corners.xlBorder * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(image!),
              SizedBox(height: Insets.med),
              Text(heading!,
                  style: TextStyles.primary.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      fontFamily: "proxima_nova_soft_regular")),
              Padding(
                padding: EdgeInsets.only(
                    left: Insets.med, right: Insets.med, top: Insets.sm),
                child: Text(label!,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: TextStyles.primary.copyWith(
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                        fontFamily: "proxima_nova_soft_regular")),
              ),
              SizedBox(height: Insets.xl),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Insets.med),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: customButton(
                          onTap: denyTap,
                          label: buttonNameDeny,
                          icon: buttonIconDeny,
                          iconPath: buttonIconDenyImage,
                          containerColor: AppTheme.white,
                          iconColor: AppTheme.buttonColor,
                          labelColor: AppTheme.buttonColor,
                          borderColor: AppTheme.buttonColor),
                    ),
                    SizedBox(
                      width: Insets.med,
                    ),
                    Expanded(
                      child: customButton(
                          onTap: allowTap,
                          label: buttonNameAllow,
                          icon: buttonIconAllow,
                          iconPath: buttonIconAllowImage,
                          containerColor: AppTheme.buttonColor,
                          iconColor: AppTheme.white,
                          labelColor: AppTheme.white,
                          borderColor: AppTheme.buttonColor),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Insets.xl)
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
      {VoidCallback? onTap,
        Color? borderColor,
        Color? containerColor,
        Color? labelColor,
        Color? iconColor,
        IconData? icon,
        String? label,
        String? iconPath}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // width: 140,
        height: 48,
        decoration: BoxDecoration(
            color: containerColor,
            border: Border.all(color: borderColor!),
            borderRadius: Corners.lgBorder),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconPath == null
                ? Icon(icon, color: iconColor)
                : SvgPicture.asset(
              iconPath,
              color: Colors.white,
            ),
            SizedBox(width: Insets.xs),
            Text(
              label!,
              style: TextStyles.primary
                  .copyWith(color: labelColor, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
