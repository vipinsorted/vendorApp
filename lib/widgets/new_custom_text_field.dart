import 'package:flutter/material.dart';

import '../styles.dart';
import '../themes.dart';

class NewTextField extends StatelessWidget {
  const NewTextField({
    Key? key,
    this.controller,
    this.label,
    this.prefix,
    this.borderColor,
    this.suffix,
    this.onChanged,
    this.backgroundColor,
    this.hintTextColor,
    this.keyBoardType,
    this.errorMessage,
    this.maxLength,
    this.enabled = true,
    this.autoFocus = false,
  }) : super(key: key);

  final String? label;
  final String? errorMessage;
  final TextEditingController? controller;
  final Widget? prefix;
  final Widget? suffix;
  final Color? hintTextColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final ValueChanged? onChanged;
  final TextInputType? keyBoardType;
  final int? maxLength;
  final bool enabled;
  final bool autoFocus;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label ?? "",
            style: TextStyles.body1,
          ),
          SizedBox(
            height: Insets.sm,
          ),
          TextField(
            controller: controller,
            autofocus: autoFocus,
            // enabled: enabled, // Using this also disables suffix and prefix
            enableInteractiveSelection: enabled, // will disable paste operation
            focusNode: enabled ? null : _AlwaysDisabledFocusNode(), // Using these instead to disable text field, as this keeps the button operational
            maxLength: maxLength,
            onChanged: onChanged,
            style: TextStyles.body1.copyWith(fontSize: FontSizes.s16),
            cursorColor: AppTheme.green,
            decoration: InputDecoration(
              prefix: prefix,
              suffix: suffix,
              contentPadding: EdgeInsets.all(Insets.lg),
              filled: enabled,
              fillColor: backgroundColor ?? AppTheme.lightGreen,
              errorText: errorMessage,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Insets.sm),
                borderSide: BorderSide(
                  color: borderColor ?? AppTheme.green,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Insets.sm),
                borderSide: BorderSide(
                  color: borderColor ?? AppTheme.green,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Insets.sm),
                borderSide: BorderSide(
                  color: AppTheme.errorRed,
                ),
              ),
              counterText: "",
            ),
            keyboardType: keyBoardType,
          )
        ],
      );
}

class _AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}