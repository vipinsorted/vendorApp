import 'package:flutter/material.dart';

import '../styles.dart';
import '../themes.dart';

Widget smallCustomButton({required VoidCallback onTap, required String text}) =>
    InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(
            left: Insets.sm,
            right: Insets.sm,
            top: Insets.xs + 2,
            bottom: Insets.xs + 2),
        decoration: BoxDecoration(
            borderRadius: Corners.avatarShadowBorder,
            border: Border.all(color: AppTheme.buttonColor)),
        child: Center(
          child: Text(text,
              style: TextStyles.primary.copyWith(
                  fontFamily: "Roboto",
                  fontSize: 12,
                  color: AppTheme.buttonColor,
                  fontWeight: FontWeight.w600)),
        ),
      ),
    );
