import 'package:flutter/material.dart';

import '../styles.dart';
import '../themes.dart';

class ElevatedCustomButton extends StatelessWidget {
  final String text;
  final onPressed;
  const ElevatedCustomButton(
      {Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        minWidth: Insets.xxl * 4,
        shape: RoundedRectangleBorder(borderRadius: Corners.lgBorder),
        color: AppTheme.buttonColor,
        onPressed: onPressed,
        child: Text(text,
            style: TextStyles.body1
                .copyWith(fontSize: 14, color: AppTheme.white)));
  }
}
