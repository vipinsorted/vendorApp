
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../strings.dart';
import '../../../styles.dart';
import '../../../themes.dart';
import '../../../widgets/rounded_check_button.dart';
import '../../number_validation_screen/controller/number_validation_controller.dart';
import '../../number_validation_screen/widget/custom_number_text_field.dart';
import '../controller/verify_otp_controller.dart';

class NewOtpScreen extends StatefulWidget {
  NewOtpScreen({
    Key? key,
    required this.name,
    required this.number,
    this.isUserFound = false,
    required this.greetings,
    required this.verificationId,
  }) : super(key: key);
  String name;
  String number;
  String greetings;
  bool isUserFound;
  String? verificationId;

  @override
  State<NewOtpScreen> createState() => _NewOtpScreenState();
}

class _NewOtpScreenState extends State<NewOtpScreen> {
  OtpController otpController = Get.put(OtpController());
  TextEditingController otpTextEditingController = TextEditingController();
  NumberValidationController numberValidationController =
      Get.put(NumberValidationController());
  String name = "";
  String number = "";
  double opacity = 0.0;
  bool isFirstTime = false;
  bool _showButton = false;
  bool _isUserFoundAnimation = false;
  bool _isUserGreetingAnimation = false;
  bool _isUserNumberAnimation = false;
  bool _isUserPrivacyText = false;
  bool _isUserOtpField = false;
  bool _isUserResendButton = false;
  final TextEditingController _firstNumberController = TextEditingController();
  final TextEditingController _secondNumberController = TextEditingController();
  final TextEditingController _thirdNumberController = TextEditingController();
  late FocusNode first4Number;
  late FocusNode second3Number;
  late FocusNode third3Number;

  FocusNode otpFocusNode = FocusNode();

  late Timer? timer;

  @override
  void initState() {
    super.initState();
    getNumber();
    startTimer();
  }

  void getNumber() {
    name = widget.name;
    number = widget.number;
    _firstNumberController.text = widget.number.substring(0, 4);
    _secondNumberController.text = widget.number.substring(4, 7);
    _thirdNumberController.text = widget.number.substring(7, 10);
    first4Number = FocusNode();
    second3Number = FocusNode();
    third3Number = FocusNode();
  }

  void startTimer() {
    Future.delayed(const Duration(milliseconds: 500), () {
      checkForUserFound();
      setState(() {});
    });
    timer = Timer.periodic(const Duration(milliseconds: 1000), (_) {
      if (otpController.secondsRemaining != 0) {
        otpController.secondsRemaining.value =
            otpController.secondsRemaining.value - 1;
      } else {
        otpController.enableResend.value = true;
        timer!.cancel();
      }
    });
  }

  void checkForUserFound() {
    if (widget.isUserFound) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _isUserFoundAnimation = true;
        setState(() {});
        Future.delayed(const Duration(milliseconds: 500), () {
          _isUserFoundAnimation = false;
          setState(() {});
          Future.delayed(const Duration(milliseconds: 500), () {
            widget.isUserFound = false;
            startNormalAnimation();
          });
        });
      });
    } else {
      startNormalAnimation();
    }
  }

  void startNormalAnimation() {
    _isUserGreetingAnimation = true;
    Future.delayed(const Duration(milliseconds: 250), () {
      _isUserNumberAnimation = true;
      setState(() {});
      Future.delayed(const Duration(milliseconds: 250), () {
        _isUserPrivacyText = true;
        setState(() {});
        Future.delayed(const Duration(milliseconds: 250), () {
          _isUserOtpField = true;
          setState(() {});
          Future.delayed(const Duration(milliseconds: 250), () {
            _isUserResendButton = true;
            otpFocusNode.requestFocus();
            otpController.resetSeconds();
            setState(() {});
          });
        });
      });
    });

    setState(() {});
  }

  changeOpacity() {
    if (isFirstTime) return;
    isFirstTime = true;
    Future.delayed(const Duration(milliseconds: 250), () {
      opacity = 1.0;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    changeOpacity();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
      floatingActionButton: roundedButton(),
      body: SafeArea(
          child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: Insets.xxl),
            SvgPicture.asset("assets/images/sorted_logo_squared.svg",
                height: 60),
            SizedBox(height: Insets.xxl + 4),
            greeting(),
            SizedBox(height: Insets.med),
            userNumber(),
            SizedBox(height: Insets.xl),
            privacyText(),
            SizedBox(height: Insets.xxl * 2),
            otpTextField(),
            SizedBox(height: Insets.xs),
            resendButton()
          ],
        ),
      )),
    );
  }

  Widget greeting() =>
      widget.isUserFound ? weFoundYouText() : userGreetingText();

  Widget weFoundYouText() => AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: _isUserFoundAnimation ? 1.0 : 0.0,
        child: Text(
          Strings.foundYou,
          textAlign: TextAlign.center,
          style: TextStyles.primary
              .copyWith(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      );

  Widget userGreetingText() => AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: _isUserGreetingAnimation ? 1.0 : 0.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${widget.greetings},",
              textAlign: TextAlign.center,
              style: TextStyles.primary
                  .copyWith(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              " ${widget.name.toString().capitalize}",
              textAlign: TextAlign.center,
              style: TextStyles.primary
                  .copyWith(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );

  Widget userNumber() => AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: _isUserNumberAnimation ? 1.0 : 0.0,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: itemSizeByParam(context, ratio: 0.1)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                Strings.number91,
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.darkYellow,
                    height: 2.5),
              ),
              SizedBox(width: Insets.xs),
              Expanded(
                  flex: 4,
                  child: CustomNumberTextField(
                    fontSize: 20,
                    focusNode: first4Number,
                    maxLength: 4,
                    onChanged: (val) {
                      if (val.length == 4) {
                        second3Number.requestFocus();
                      }
                    },
                    controller: _firstNumberController,
                  )),
              SizedBox(width: Insets.sm),
              Expanded(
                  flex: 3,
                  child: CustomNumberTextField(
                    fontSize: 20.0,
                    focusNode: second3Number,
                    maxLength: 3,
                    onChanged: (val) {
                      if (val.length == 3) {
                        third3Number.requestFocus();
                      } else if (val.length == 0) {
                        first4Number.requestFocus();
                      }
                    },
                    controller: _secondNumberController,
                  )),
              SizedBox(width: Insets.sm),
              Expanded(
                  flex: 3,
                  child: CustomNumberTextField(
                    fontSize: 20.0,
                    focusNode: third3Number,
                    maxLength: 3,
                    onChanged: (val) {
                      if (val.length == 0) {
                        second3Number.requestFocus();
                      }
                      sendOtp();
                    },
                    onSubmitted: (val) {},
                    controller: _thirdNumberController,
                  )),
              Padding(
                padding: EdgeInsets.only(top: Insets.lg, left: Insets.xs),
                child: InkWell(
                    onTap: () {
                      third3Number.requestFocus();
                      // sendOtp();
                    },
                    child: const Icon(Icons.create_outlined,
                        color: AppTheme.darkYellow)),
              )
            ],
          ),
        ),
      );

  Widget privacyText() => AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: _isUserPrivacyText ? 1.0 : 0.0,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Insets.xxl * 1.5),
          child: AnimatedOpacity(
            opacity: opacity,
            duration: const Duration(milliseconds: 600),
            child: Text(
              Strings.privacyMessage,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyles.primary
                  .copyWith(fontSize: 18, height: 1.3, color: AppTheme.black),
            ),
          ),
        ),
      );

  Widget otpTextField() => AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: _isUserOtpField ? 1.0 : 0.0,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Insets.xxl * 3),
          child: PinFieldAutoFill(
            controller: otpTextEditingController,
            focusNode: otpFocusNode,
            decoration: const UnderlineDecoration(
              lineHeight: 2,
              gapSpace: 6,
              textStyle: TextStyle(fontSize: 20, color: Colors.black),
              colorBuilder: FixedColorBuilder(AppTheme.darkYellow),
            ),
            onCodeChanged: (code) {
              if (code!.length == 6) {
                otpController.fetchOtp(
                  otpTextEditingController.text,
                  name,
                  getFullNumber(),
                  widget.greetings,
                  widget.verificationId,
                  context,
                );
                _showButton = true;
                setState(() {});
                FocusScope.of(context).requestFocus(FocusNode());
              }
            },
          ),
        ),
      );

  Widget roundedButton() => _showButton == true
      ? Padding(
          padding: EdgeInsets.only(bottom: Insets.lg),
          child: RoundedButton(
              borderColor: AppTheme.buttonColor,
              iconColor: AppTheme.buttonColor,
              icon: "assets/images/checked.svg",
              onTap: () {},
              iconHeight: 20),
        )
      : const SizedBox();

  Widget resendButton() {
    return Obx(() => AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: _isUserResendButton ? 1.0 : 0.0,
          child: TextButton(
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(AppTheme.grey
                      .withOpacity(
                          otpController.enableResend.value ? 1.0 : 0.2))),
              onPressed: () async {
                if (otpController.enableResend.value) {
                  await numberValidationController.fetchOtp(
                      getFullNumber(), null, context,
                      isNavigate: false);
                  otpController.resetSeconds();
                  startTimer();
                }
              },
              child: Text(
                  "( ${otpController.secondsRemaining.value} ) ${Strings.resendCode}",
                  style: TextStyles.primary.copyWith(
                      fontSize: 16,
                      // color: AppTheme.grey.withOpacity(
                      //     otpController.enableResend.value ? 1.0 : 0.7),
                      color: otpController.enableResend.value
                          ? Colors.black
                          : AppTheme.grey,
                      fontWeight: FontWeight.w500))),
        ));
  }

  String getFullNumber() =>
      _firstNumberController.text +
      _secondNumberController.text +
      _thirdNumberController.text;

  sendOtp() async {
    String enteredNumber = getFullNumber();

    if (enteredNumber.length == 10) {
      // bool? isFirebaseLoginEnabled =
      //     await SharedPref.getBoolWithKey(SharedPref.IS_FIREBASE_ENABLED);

      // if (isFirebaseLoginEnabled!) {
      //   await numberValidationController.loginWithFirebase(
      //     enteredNumber,
      //     context,
      //   );
      // } else {
      await numberValidationController.fetchOtp(enteredNumber, null, context,
          isNavigate: false);
      // }
    }
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    timer = null;
  }

  double itemSizeByParam(BuildContext context, {double ratio = 1.0}) =>
      context.width * ratio;

  double itemSize(BuildContext context) => context.width * 0.22;
}
