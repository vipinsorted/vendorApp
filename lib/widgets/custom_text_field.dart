import 'package:flutter/material.dart';

import '../styles.dart';
import '../themes.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.borderColor,
    this.suffixIcon,
    this.borderWidth,
    this.onChanged,
    this.hintTextColor});

  final String? hintText;
  final TextEditingController? controller;
  final Icon? prefixIcon;
  final IconButton? suffixIcon;
  final Color? hintTextColor;
  final Color? borderColor;
  final double? borderWidth;
  final ValueChanged? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: Insets.med, right: Insets.med),
      margin: EdgeInsets.only(top: Insets.xs, bottom: Insets.xs),
      decoration: BoxDecoration(
        border: Border.all(
            color: borderColor ?? AppTheme.grey.withOpacity(0.2),
            width: borderWidth ?? 1.6),
        borderRadius: Corners.smBorder * 4,
      ),
      child: TextField(
        onChanged: onChanged,
        style: TextStyles.primary.copyWith(
            fontFamily: "proxima_nova_soft_regular",
            fontWeight: FontWeight.w600),
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          hintStyle: TextStyles.primary.copyWith(
              fontSize: 13,
              fontFamily: "proxima_nova_soft_regular",
              color: hintTextColor ?? AppTheme.black.withOpacity(0.4),
              fontWeight: FontWeight.w500),
          hintText: hintText,

        ),
      ),
    );
  }
}
