import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:vendor_app/logger.dart';
import 'package:vendor_app/network/service_exception.dart';
import 'package:vendor_app/repo/login_repo.dart';
import 'package:vendor_app/screens/number_validation_screen/model/number_validation_model.dart';
import 'package:vendor_app/strings.dart';

import '../../number_validation_screen/screen/number_validation_screen.dart';
import '../model/login_model.dart';

class LoginController extends GetxController {
  NumberValidation numberValidation = NumberValidation();
  LoginUserModel loginUserModel = LoginUserModel();

  RxString errorMessage = "".obs;
  Rx<FormzStatus> formStatus = FormzStatus.pure.obs;

  @override
  void onInit() {
    fetchUser();
    super.onInit();
  }

  Future fetchOtp(String number, BuildContext context) async {
    try {
      formStatus.value = FormzStatus.submissionInProgress;
      NumberValidation? validation = await LoginRepo.numberValidation(number);
      if (validation != null && validation.success) {
        numberValidation = validation;
        formStatus.value = FormzStatus.submissionSuccess;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NumberValidationScreen(
              phoneNumber: number,
            ),
          ),
        );
      } else {
        logger.d("number screen :${Strings.someThingWentWrong}");
        Get.showSnackbar(GetSnackBar(
          title: Strings.someThingWentWrong,
        ));
      }
      formStatus.value = FormzStatus.pure;
    } on RepoServiceException catch (e) {
      logger.e(e.message);
      errorMessage.value = e.message!;
      showSnackBar(e.message!);
      formStatus.value = FormzStatus.pure;
    } catch (e) {
      showSnackBar(
        Strings.someThingWentWrong,
      );
      formStatus.value = FormzStatus.pure;
    }
  }

  void resetForm() {
    numberValidation = NumberValidation();
    errorMessage.value = "";
    formStatus.value = FormzStatus.pure;
  }

  showSnackBar(String message) => Get.showSnackbar(
        GetSnackBar(
          message: message,
          duration: Duration(
            seconds: 5,
          ),
        ),
      );

  void fetchUser() async {
    try {
      LoginRepo.createUser();
    } on RepoServiceException catch (e) {
      logger.e(e.message);
      errorMessage.value = e.message!;
    }
  }
}
