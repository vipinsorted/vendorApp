import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:vendor_app/logger.dart';
import 'package:vendor_app/network/service_exception.dart';
import 'package:vendor_app/repo/login_repo.dart';
import 'package:vendor_app/routes/app_routes.dart';
import 'package:vendor_app/screens/number_validation_screen/model/number_validation_model.dart';
import 'package:vendor_app/strings.dart';

import '../../../repo/profile_repo.dart';
import '../../name/model/name_update_request.dart';
import '../model/login_model.dart';

class LoginController extends GetxController {
  NumberValidation numberValidation = NumberValidation();
  LoginUserModel loginUserModel = LoginUserModel();

  RxString errorMessage = "".obs;
  RxBool isNumberSubmitted = false.obs;
  Rx<FormzStatus> formStatus = FormzStatus.pure.obs;

  @override
  void onInit() {
    fetchUser();
    super.onInit();
  }

  Future fetchOtp(String number) async {
    try {
      formStatus.value = FormzStatus.submissionInProgress;
      NumberValidation? validation = await LoginRepo.numberValidation(number);
      if (validation != null && validation.success) {
        numberValidation = validation;
        isNumberSubmitted.value = true;
        formStatus.value = FormzStatus.submissionSuccess;
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

  void resetForm() {
    numberValidation = NumberValidation();
    errorMessage.value = "";
    isNumberSubmitted.value = false;
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
