import 'package:flutter/material.dart';

import '../styles.dart';
import '../themes.dart';

class NewCustomButton extends StatelessWidget {
  const NewCustomButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.backgroundColor,
    this.selected = false,
    this.elevation = 0,
  }) : super(key: key);
  final String title;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final bool selected;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: Insets.xs * 1.5,
          horizontal: Insets.sm,
        ),
        decoration: BoxDecoration(
          color: selected ? AppTheme.buttonColor : AppTheme.white,
          border: selected
              ? null
              : Border.all(
                  color: AppTheme.borderColor,
                ),
          borderRadius: BorderRadius.circular(Insets.xs),
        ),
        child: Text(
          title,
          style: TextStyles.body2.copyWith(
            color: selected ? AppTheme.white : AppTheme.disabledText,
          ),
        ),
      ),
    );
  }
}
