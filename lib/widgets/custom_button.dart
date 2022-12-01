import 'package:flutter/material.dart';
import 'package:vendor_app/widgets/custom_loader.dart';

import '../styles.dart';
import '../themes.dart';

Widget CustomButton({
  required VoidCallback onTap,
  required String name,
  IconData? icon,
  bool showIcon = false,
  bool disabled = false,
  Widget? child,
}) =>
    GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: !disabled ? onTap : null,
        child: Container(
            height: Insets.xs * 12.5,
            decoration: BoxDecoration(
                color: !disabled ? AppTheme.green : AppTheme.greySliderColor,
                borderRadius: Corners.medBorder * 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (showIcon) ...[
                  Icon(icon, size: 24, color: AppTheme.white),
                  SizedBox(width: Insets.xs),
                ],
                (child == null) ?
                Text(
                  name,
                  style: TextStyles.body1.copyWith(
                      fontFamily: "Roboto",
                      color: AppTheme.white,
                      fontWeight: FontWeight.bold),
                ) : child,
              ],
            )));
