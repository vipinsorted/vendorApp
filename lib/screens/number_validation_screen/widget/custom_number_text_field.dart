import 'package:flutter/material.dart';

import '../../../themes.dart';

class CustomNumberTextField extends StatelessWidget {
  final FocusNode? focusNode;
  final int? maxLength;
  final TextEditingController? controller;
  final ValueChanged? onChanged;
  final double? fontSize;
  final ValueChanged? onSubmitted;

  const CustomNumberTextField(
      {Key? key,
      this.focusNode,
      this.maxLength,
      this.controller,
      this.fontSize,
      this.onChanged,
        this.onSubmitted
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        focusNode: focusNode,
        maxLength: maxLength,
        keyboardType: TextInputType.phone,
        textAlign: TextAlign.center,
        style:  TextStyle(
          letterSpacing: 4,
          fontSize: fontSize,
        ),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(top: 20),
          counterText: "",
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 2, color: AppTheme.darkYellow),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 2, color: AppTheme.darkYellow),
          ),
        ),
        onChanged: onChanged,
      onSubmitted:onSubmitted ,
    );
  }
}
