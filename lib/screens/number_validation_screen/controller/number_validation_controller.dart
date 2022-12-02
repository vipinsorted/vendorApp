// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'package:formz/formz.dart';
import 'package:get/get.dart';

import '../../../logger.dart';
import '../../../network/service_exception.dart';
import '../../../repo/login_repo.dart';
import '../../../repo/profile_repo.dart';
import '../../../routes/app_routes.dart';
import '../../../strings.dart';

import '../../name/model/name_update_request.dart';
import '../../sign_in_screen/model/login_model.dart';
import '../model/number_validation_model.dart';

class NumberValidationController extends GetxController {

  RxString errorMessage = "".obs;
  NumberValidation numberValidation = NumberValidation();
  LoginUserModel loginUserModel = LoginUserModel();

  RxBool isNumberSubmitted = false.obs;
  Rx<FormzStatus> formStatus = FormzStatus.pure.obs;

  Future verifyOtp(String otp, String number) async {
    try {
      if (otp.length != 6) {
        showSnackBar(Strings.otpLength);
      }
      formStatus.value = FormzStatus.submissionInProgress;
      LoginUserModel? validation = await LoginRepo.otpVerify(otp, number);
      if (validation != null) {
        loginUserModel == validation;
        await nameUpdate(validation.user!.name!, validation.user!.greeting!);
        formStatus.value = FormzStatus.submissionSuccess;
        print("User Info got -> ${validation}");
        Get.offAndToNamed(Routes.homeScreen);
      }
    } on ServiceException catch (e) {
      logger.e(e.message);
      errorMessage.value = e.message!;
      showSnackBar(e.message!);
      formStatus.value = FormzStatus.pure;
    } catch (e) {
      logger.d(e);
      showSnackBar(Strings.someThingWentWrong);
      formStatus.value = FormzStatus.pure;
    }
  }

  Future<bool> nameUpdate(String updateName, String greet,
      {bool isNew = true}) async {
    try {
      User? profileUpdate = await ProfileRepo.updateProfile(
          NameUpdateRequestModel(name: updateName, greeting: greet));
      if (profileUpdate != null) {
        return true;
      } else {
        logger.d("number screen :${Strings.someThingWentWrong}");
        return false;
      }
    } on RepoServiceException catch (e) {
      logger.e(e.message);
      errorMessage.value = e.message!;
      return false;
    }
  }

  showSnackBar(String message) => Get.showSnackbar(
    GetSnackBar(
      message: message,
      duration: Duration(
        seconds: 5,
      ),
    ),
  );

}
