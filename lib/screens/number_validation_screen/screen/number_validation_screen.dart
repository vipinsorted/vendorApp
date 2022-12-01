import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../strings.dart';
import '../../../styles.dart';
import '../../../themes.dart';
import '../../../widgets/custom_button.dart';
import '../controller/number_validation_controller.dart';

class NumberValidationScreen extends StatefulWidget {
  const NumberValidationScreen({Key? key}) : super(key: key);

  @override
  State<NumberValidationScreen> createState() => _NumberValidationScreenState();
}

class _NumberValidationScreenState extends State<NumberValidationScreen> {
  NumberValidationController numberValidationController =
      Get.put(NumberValidationController());
  final TextEditingController _numberController = TextEditingController();
  bool _clickButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }

  //body part
  Widget _buildBody() => Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [AppTheme.backgroundGradient, AppTheme.white],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter)),
        child: Stack(
          children: [
            headerPart(),
            bottomPart(),
          ],
        ),
      );

  //background image
  Widget headerPart() => Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [AppTheme.backgroundGradient, AppTheme.white],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter)),
        padding: EdgeInsets.only(
            left: Insets.xs * 5, right: Insets.xs * 5, top: Insets.xs * 2.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: Insets.sm * 7.5),
            SvgPicture.asset("assets/images/logo.svg",
                fit: BoxFit.cover, height: Insets.sm * 10),
            SizedBox(height: Insets.med * 6),
            Image.asset("assets/images/background.jpg"),
            SizedBox(height: Insets.xs * 5)
          ],
        ),
      );

  //textField and button container
  Widget bottomPart() => Positioned(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25.0, sigmaY: 25.0),
              child: Container(
                  padding: EdgeInsets.only(
                      left: Insets.med + 2,
                      right: Insets.med + 2,
                      top: Insets.xs * 5,
                      bottom: Insets.xs * 2.5),
                  margin: EdgeInsets.only(
                      left: Insets.med + 2,
                      right: Insets.med + 2,
                      top: Insets.xs * 5,
                      bottom: Insets.xs * 2.5),
                  width: double.infinity,
                  height: Insets.xxl * 6.75,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(Strings.awesome,
                          style: TextStyles.primary
                              .copyWith(fontWeight: FontWeight.bold)),
                      SizedBox(height: Insets.xs + 2),
                      Text(Strings.loginWithNumberMsg,
                          style: TextStyles.primary.copyWith(
                              color: AppTheme.black.withOpacity(0.7),
                              fontSize: 12,
                              fontWeight: FontWeight.w300)),
                      SizedBox(height: Insets.med * 2.5),
                      Text(Strings.phoneNumber,
                          style: TextStyles.primary.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.grey)),
                      textField(),
                      SizedBox(height: Insets.xs * 5),
                      _clickButton
                          ? CustomButton(
                              name: Strings.continueButton,
                              onTap: () async {
                                if (_numberController.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: Strings.enterNumber);
                                  return;
                                } else if (_numberController.text.length !=
                                    10) {
                                  Fluttertoast.showToast(
                                      msg: Strings.enterValidNumber);
                                  return;
                                } else {
                                  numberValidationController
                                      .fetchOtp(_numberController.text, null, context);
                                  _numberController.clear();
                                }
                              })
                          : Container(
                              height: Insets.xs * 12.5,
                              decoration: BoxDecoration(
                                  color: AppTheme.buttonColor.withOpacity(0.3),
                                  borderRadius: Corners.medBorder * 2),
                              child: Center(
                                child: Text(
                                  Strings.continueButton,
                                  style: TextStyles.body1.copyWith(
                                      color: AppTheme.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                      SizedBox(height: Insets.med),
                      termsAndCondition(),
                      SizedBox(height: Insets.med)
                    ],
                  )),
            ),
          ),
        ),
      );

  //textField
  Widget textField() => TextField(
      onTap: () {
        _clickButton = true;
        setState(() {});
      },
      controller: _numberController,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintStyle: TextStyles.primary
            .copyWith(color: AppTheme.black, fontWeight: FontWeight.bold),
        hintText: "+91",
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(width: 2, color: AppTheme.darkYellow)),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(width: 2, color: AppTheme.darkYellow)),
      ));

  //richText
  Widget termsAndCondition() => Center(
        child: RichText(
          maxLines: 1,
          textAlign: TextAlign.center,
          text: TextSpan(
              style: TextStyles.primary
                  .copyWith(color: AppTheme.black, fontSize: 10),
              children: [
                const TextSpan(text: "By clicking, I accept the "),
                TextSpan(
                    recognizer: TapGestureRecognizer()..onTap,
                    text: Strings.termsCondition,
                    style: TextStyles.primary
                        .copyWith(fontSize: 12, fontWeight: FontWeight.bold)),
                const TextSpan(text: " and "),
                TextSpan(
                    recognizer: TapGestureRecognizer()..onTap,
                    text: Strings.privacyPolicy,
                    style: TextStyles.primary
                        .copyWith(fontSize: 12, fontWeight: FontWeight.bold))
              ]),
        ),
      );
}
