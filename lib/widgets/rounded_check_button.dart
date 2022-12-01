import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../styles.dart';
import '../themes.dart';

class RoundedButton extends StatelessWidget {
  final String? icon;
  final VoidCallback? onTap;
  final double? iconHeight;
  final Color? iconColor;
  final Color? borderColor;
  const RoundedButton(
      {super.key,
      this.icon,
      this.onTap,
      this.iconHeight,
      this.iconColor,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(
            left: Insets.lg + 2,
            right: Insets.lg + 2,
            top: Insets.lg + 2,
            bottom: Insets.lg + 2),
        decoration: BoxDecoration(
            color: AppTheme.white,
            shape: BoxShape.circle,
            border: Border.all(color: borderColor!, width: 2.9)),
        child: SvgPicture.asset(
          icon!,
          height: iconHeight,
          color: iconColor,
        ),
      ),
    );
  }
}
