import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static const greenSelecetedCategoryColor = Color(0xFFEFF7E2);
  static const shadowColor = Color(0xFF0000001A);
  static const greytrackScreen = Color(0xFFF5F5F5);
  static const bool isDark = false;
  static const double maxWidth = 800;
  static const brownOptionScreen = Color(0xFF92503C);
  static const greyBottomSheet = Color(0xFFEFEFEF);
  static const greytrack2 = Color(0xFF959595);
  static const black = Color(0xFF333333);
  static const skinColor = Color(0xFFFCF7EF);
  static const white = Color(0xFFFFFFFF);

  static const darkGreen = Color(0xFF869375);
  static const graphIronColor = Color(0xFF4A5568);
  static const primaryColor1 = Color(0xff91c11e);
  static const primaryColor2 = Color(0xFF333333);
  static const errorRed = Color(0xFFEB5757);
  static const greySliderColor = Color(0xFFDEDEDE);
  static const lightGreenSliderColor = Color(0xFFBFE094);
  static const subHeadingColor = Color(0xFFAA9D8A);
  static const searchTextFieldColor = Color(0xFFFFF7EB);
  static const darkYellow = Color(0xFFBB8C46);
  static const shadow = Color(0xB48D5136);
  static const brown = Color(0xFF624E2F);
  static const borderAvatar = Color(0xFFD8CBB8);
  static const iconColor = Color(0xFF707070);
  static const backgroundGradient = Color(0xFFF5EBDC);
  static const backgroundColor = Color(0xFFF0EDE7);
  static const buttonColor = Color(0xFF27AE60);
  static const buttonColorDisable = Color(0xFFA1AF97);
  static const borderColor = Color(0xE0E0E0E0);
  static const disabledText = Color(0xFFBDBDBD);
  static const containerWhite = Color(0xFFFFFFFF);
  static const purple = Color(0xFF9D5A9B);
  static const blue = Color(0xFF4797D2);
  static const grey = Colors.grey;
  static const red = Color(0xFFDA5239);
  static const textBlack = Color(0xFF000000);
  static const cyan = Color(0xFF40B2BF);
  static const mustardYellow = Color(0xFFffbe00);
  static const elSalva = Color(0xFF9C4C36);
  static const roundedButton = Color(0xFFD58253);
  static const blackForText=Color(0xFF4A5568);
  static const newGreen = Color(0xFf95A583);
  static const inactiveSlider = Color(0xFFFFF7EB);
  static const moneyGreen = Color(0xFF779B58);
  static const redPersonal = Color(0xFFDE503F);
  static const everythingElseBrown = Color(0xFFBD8B51);
  static const orderText = Color(0xffE2EFE8);
  static const greenBackground = Color(0xffC2CCC6);
  // static const green = Color(0xff6A7949);
  static const asparagus = Color(0xff809A57);
  static const cabbagePont = Color(0xff405139);
  static const dustyGrey = Color(0xff959595);
  static const alto = Color(0xffD8D8D8);
  static const opium = Color(0xff8E7069);
  static const silverChalice = Color(0xffAFAFAF);
  static const athsSpecial = Color(0xffEDE2D3);
  static const lightBlue = Color(0xffE4ECF7);
  static const blueBorder = Color(0xffC8D2E0);

  static const green = Color(0xFF6FCF97);
  static final lightGreen = Color.fromRGBO(233, 255, 242, .3);

  Color shift(Color c, double amt) {
    amt *= (isDark ? -1 : 1);
    var hslc = HSLColor.fromColor(c); // Convert to HSL
    double lightness =
        (hslc.lightness + amt).clamp(0, 1.0) as double; // Add/Remove lightness
    return hslc.withLightness(lightness).toColor(); // Convert back to Color
  }
}
