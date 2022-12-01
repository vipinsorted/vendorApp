import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../styles.dart';
import '../themes.dart';

class CustomAddressButton extends StatelessWidget {
  const CustomAddressButton(
      {super.key,
      this.svgColor,
      this.text,
      this.textColor,
      this.color,
      this.onTap,
      this.showIcon,
      this.svgPicture,
      this.iconHeight});

  final String? svgPicture;

  final Color? svgColor;

  final String? text;

  final Color? textColor;

  final Color? color;

  final VoidCallback? onTap;

  final bool? showIcon;
  final double? iconHeight;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onTap,
      child: Container(
        // padding: EdgeInsets.only(
        //     left: Insets.xs,
        //     right: Insets.xs,
        //     top: Insets.med,
        //     bottom: Insets.med),
        // height: 38,
        // width: 90,
        height: 34,
        width: 80,
        margin: EdgeInsets.all(Insets.xs),
        decoration: BoxDecoration(
            color: color,
            border: Border.all(color: AppTheme.grey.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(Insets.med * 2.5)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            showIcon == true
                ? SvgPicture.asset(
                    svgPicture!,
                    color: svgColor,
                    fit: BoxFit.fill,
                    height: iconHeight,
                  )
                : const SizedBox(),
            SizedBox(width: Insets.xs),
            Text(
              text!,
              style: TextStyles.primary.copyWith(
                  color: textColor,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
