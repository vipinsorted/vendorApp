import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:vendor_app/styles.dart';
import 'package:vendor_app/widgets/custom_loader.dart';
import 'package:vendor_app/widgets/new_custom_text_field.dart';

import '../../../themes.dart';
import '../../../widgets/custom_button.dart';
import '../controller/signup_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.put(LoginController());


  TextEditingController numberController = TextEditingController();

  TextEditingController otpController = TextEditingController();

  String otp = "";

  @override
  void dispose() {
    numberController.dispose();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: SingleChildScrollView(
            child: Container(
              width: Get.width,
              height: Get.height,
              padding: EdgeInsets.symmetric(
                horizontal: Insets.xl,
                vertical: Insets.xxl * 2.25,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/groceries.svg',
                    fit: BoxFit.contain,
                    height: 150,
                    width: 150,
                  ),
                  SizedBox(
                    height: Insets.xxl * 1.7,
                  ),
                  Container(
                    width: Get.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Log in to your Fresh Account",
                          style: TextStyles.h2,
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: Insets.xxl,
                        ),
                        NewTextField(
                          controller: numberController,
                          maxLength: 10,
                          autoFocus: true,
                          label: "Enter Mobile Number",
                          keyBoardType: TextInputType.number,
                          // enabled: !loginController.isNumberSubmitted.value,
                          suffix: Visibility(
                            visible: loginController.isNumberSubmitted.value,
                            child: GestureDetector(
                              onTap: () {
                                loginController.resetForm();
                                otpController.clear();
                              },
                              child: Text("Edit"),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Insets.xl,
                        ),
                        Visibility(
                          visible: loginController.isNumberSubmitted.value,
                          child: NewTextField(
                            onChanged: (newOtp) {
                              print(newOtp);
                              otp = newOtp;
                              setState(() {});
                            },
                            maxLength: 6,
                            controller: otpController,
                            label: "Enter OTP",
                            keyBoardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Insets.xl,
                  ),
                  CustomButton(
                    onTap: () {
                      if (!loginController.isNumberSubmitted.value) {
                        loginController.fetchOtp(numberController.text);
                      } else {
                        loginController.verifyOtp(otp, numberController.text);
                      }
                    },
                    name: !loginController.isNumberSubmitted.value
                        ? 'Generate OTP'
                        : 'Log In',
                    child: loginController.formStatus.value ==
                            FormzStatus.submissionInProgress
                        ? showCircularLoader()
                        : null,
                    disabled:
                        loginController.formStatus.value != FormzStatus.pure,
                  ),
                  Visibility(
                    visible: loginController.isNumberSubmitted.value,
                    child: TextButton(
                      onPressed: () {
                        otpController.clear();
                        loginController.fetchOtp(numberController.text);
                      },
                      child: Text(
                        "Resend OTP",
                        style: TextStyles.body2.copyWith(color: AppTheme.green),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
