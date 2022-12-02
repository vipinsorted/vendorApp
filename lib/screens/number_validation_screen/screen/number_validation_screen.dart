
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';

import '../../../styles.dart';
import '../../../themes.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_loader.dart';
import '../../../widgets/new_custom_text_field.dart';
import '../../sign_in_screen/controller/signup_controller.dart';
import '../controller/number_validation_controller.dart';

class NumberValidationScreen extends StatefulWidget {
  const NumberValidationScreen({Key? key, required this.phoneNumber, }) : super(key: key);
  final String phoneNumber;

  @override
  State<NumberValidationScreen> createState() => _NumberValidationScreenState();
}

class _NumberValidationScreenState extends State<NumberValidationScreen> {
  NumberValidationController numberValidationController =
      Get.put(NumberValidationController());
  LoginController loginController = Get.find();
  late TextEditingController numberController;
  TextEditingController otpController = TextEditingController();

  @override
  void initState() {
    numberController = TextEditingController(text: widget.phoneNumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
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
                        label: "Enter Mobile Number",
                        keyBoardType: TextInputType.number,
                        enabled: false,
                      ),
                      SizedBox(
                        height: Insets.xl,
                      ),
                      NewTextField(
                        maxLength: 6,
                        controller: otpController,
                        label: "Enter OTP",
                        autoFocus: true,
                        keyBoardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Insets.xl,
                ),
                CustomButton(
                  onTap: () {
                      numberValidationController.verifyOtp(otpController.text, numberController.text);
                  },
                  name: 'Generate OTP',
                  child: numberValidationController.formStatus.value ==
                          FormzStatus.submissionInProgress
                      ? showCircularLoader()
                      : null,
                  disabled: numberValidationController.formStatus.value != FormzStatus.pure,
                ),
                TextButton(
                  onPressed: null,
                  //     () {
                  //   otpController.clear();
                  //   // loginController.fetchOtp(numberController.text, context);
                  // },

                  child: Text(
                    "Resend OTP",
                    style: TextStyles.body2.copyWith(color: AppTheme.green),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
