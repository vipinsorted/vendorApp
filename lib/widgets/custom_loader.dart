import 'package:flutter/material.dart';

import '../styles.dart';
import '../themes.dart';

Widget showCircularLoader() {
  return Center(
      child: SizedBox(
          width: Insets.lg,
          height: Insets.lg,
          child: const CircularProgressIndicator(
            color: AppTheme.darkYellow,
            strokeWidth: 2,
          )));
}
