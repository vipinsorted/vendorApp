import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:vendor_app/styles.dart';
import 'package:vendor_app/widgets/custom_loader.dart';
import 'package:vendor_app/widgets/new_custom_text_field.dart';

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

  @override
  void dispose() {
    numberController.dispose();
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
                        ),
                        SizedBox(
                          height: Insets.xl,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Insets.xl,
                  ),
                  CustomButton(
                    onTap: () => loginController.fetchOtp(numberController.text, context),
                    name: 'Generate OTP',
                    child: loginController.formStatus.value ==
                            FormzStatus.submissionInProgress
                        ? showCircularLoader()
                        : null,
                    disabled:
                        loginController.formStatus.value != FormzStatus.pure,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
