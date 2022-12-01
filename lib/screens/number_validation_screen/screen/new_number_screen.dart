import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../logger.dart';
import '../../../network/shared_prefs.dart';
import '../../../strings.dart';
import '../../../styles.dart';
import '../../../themes.dart';
import '../../../widgets/loading_lottie.dart';
import '../../home_screen/home_screen.dart';
import '../controller/number_validation_controller.dart';
import '../widget/custom_number_text_field.dart';

class NewMobileScreen extends StatefulWidget {
  const NewMobileScreen({Key? key}) : super(key: key);

  @override
  State<NewMobileScreen> createState() => _NewMobileScreenState();
}

class _NewMobileScreenState extends State<NewMobileScreen> {
  double opacity = 1.0;
  bool isFirstTime = false;
  bool _isChecked = true;
  // late CurrentAddressModel? currentAddressModel;
  NumberValidationController numberValidationController =
      Get.put(NumberValidationController());
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();
  final TextEditingController _thirdController = TextEditingController();
  late FocusNode first4Number;
  late FocusNode second3Number;
  late FocusNode third3Number;

  changeOpacity() {
    if (isFirstTime) return;
    isFirstTime = true;
    Future.delayed(const Duration(milliseconds: 200), () {
      opacity = 0.0;
      setState(() {});
    });
  }

  @override
  void initState() {
    first4Number = FocusNode();
    second3Number = FocusNode();
    third3Number = FocusNode();
    init();
    super.initState();
  }

  void init() async {
    // currentAddressModel = await SharedPref.getCurrentAddress();
  }

  @override
  Widget build(BuildContext context) {
    numberValidationController.setContext(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              color: AppTheme.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: Insets.xxl),
                  header(),
                  numberInput(),
                  SizedBox(
                    height: Insets.xl,
                  ),
                  agreement(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  // if (currentAddressModel?.latitude == null ||
                  //     currentAddressModel?.latitude == 0.0) {
                  //   Get.off(() => MapScreen(
                  //     mapRole: MapRole.homePopUp,
                  //   ));
                  // } else {
                    // AppRoutes.offNamed(Routes.optionScreen);
                    Get.off(const HomeScreen());
                  // }
                },
                child: Text(Strings.skip,
                    style: TextStyles.primary.copyWith(
                        fontSize: 18,
                        color: AppTheme.grey,
                        fontWeight: FontWeight.w500)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget header() => Column(
        children: [

          SvgPicture.asset("assets/images/sorted_logo_squared.svg", height: 60),
          SizedBox(height: Insets.xxl * 2.3),
          Text(
            Strings.alreadySorted,
            textAlign: TextAlign.center,
            style: TextStyles.primary
                .copyWith(fontWeight: FontWeight.w500, fontSize: 24),
          ),
          SizedBox(height: Insets.xxl + 12),
        ],
      );

  Widget numberInput() => AnimatedOpacity(
        opacity: opacity,
        duration: const Duration(milliseconds: 500),
        child: Padding(
          padding: EdgeInsets.only(left: Insets.xxl, right: Insets.xxl),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: Insets.lg + 2),
                child: Text("+91",
                    style: TextStyles.primary.copyWith(
                        color: AppTheme.darkYellow,
                        fontSize: Insets.lg + 10.0,
                        fontWeight: FontWeight.w500)),
              ),
              SizedBox(width: Insets.xs),
              Expanded(
                  flex: 4,
                  child: CustomNumberTextField(
                      fontSize: 28.0,
                      controller: _firstController,
                      focusNode: first4Number,
                      maxLength: 4,
                      onChanged: (val) {
                        if (val.length == 4) {
                          second3Number.requestFocus();
                        }
                      })),
              SizedBox(width: Insets.med),
              Expanded(
                  flex: 3,
                  child: CustomNumberTextField(
                    fontSize: 28.0,
                    controller: _secondController,
                    maxLength: 3,
                    focusNode: second3Number,
                    onChanged: (val) {
                      if (val.length == 3) {
                        third3Number.requestFocus();
                      } else if (val.length == 0) {
                        first4Number.requestFocus();
                      }
                      setState(() {});
                    },
                  )),
              SizedBox(width: Insets.med),
              Expanded(
                  flex: 3,
                  child: CustomNumberTextField(
                    fontSize: 28.0,
                    controller: _thirdController,
                    maxLength: 3,
                    focusNode: third3Number,
                    onChanged: (val) async {
                      if (val.length == 0) {
                        second3Number.requestFocus();
                      } else if (val.length == 3) {
                        validateAndSendNumber();
                      }
                    },
                  )),
            ],
          ),
        ),
      );

  Widget agreement() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Checkbox(
              activeColor: AppTheme.darkYellow,
              value: _isChecked,
              onChanged: (value) {
                _isChecked = value!;
                setState(() {});
              }),
          Text(Strings.agreeTo,
              style: TextStyles.primary.copyWith(
                  color: Colors.black,
                  fontFamily: "proxima_nova_soft_regular")),
          // InkWell(
          //   onTap: () async {
          //     String? url = await SharedPref.getTermsAndConditionUrl();
          //     Get.to(SlidingScreen(url: url ?? Strings.companyURL));
          //   },
          //   child: const Text(Strings.terms,
          //       style: TextStyle(
          //           fontWeight: FontWeight.bold,
          //           fontFamily: "proxima_nova_soft_regular",
          //           decoration: TextDecoration.underline)),
          // ),
        ],
      );

  Widget customNumberTextField(
      {FocusNode? focusNode,
      int? maxLength,
      TextEditingController? controller,
      ValueChanged? onChanged}) {
    return TextField(
        controller: controller,
        focusNode: focusNode,
        maxLength: maxLength,
        keyboardType: TextInputType.phone,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 32.0,
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
        onChanged: onChanged);
  }

  void validateAndSendNumber() async {
    if (!_isChecked) {
      return;
    }
    String firstValue = _firstController.text;
    String secondValue = _secondController.text;
    String thirdValue = _thirdController.text;

    if (firstValue.isEmpty || secondValue.isEmpty || thirdValue.isEmpty) {
      return;
    }
    String number = firstValue + secondValue + thirdValue;
    bool? isFirebaseLoginEnabled = await SharedPref.getBoolWithKey(SharedPref.IS_FIREBASE_ENABLED);
   logger.d("$isFirebaseLoginEnabled ++++++++++++++  $number");
    if(isFirebaseLoginEnabled!) {
    LoadingLottie.loadingLottie(context);
      await numberValidationController
          .fetchOtp(number, null, context);
    }else {
      await numberValidationController.fetchOtp(number, null, context);
    }
  }
}
