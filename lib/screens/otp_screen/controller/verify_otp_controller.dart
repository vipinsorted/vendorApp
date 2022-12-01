import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../logger.dart';
import '../../../network/service_exception.dart';
import '../../../network/shared_prefs.dart';
import '../../../repo/login_repo.dart';
import '../../../repo/profile_repo.dart';
import '../../../strings.dart';
import '../../home_screen/home_screen.dart';
import '../../name/model/name_update_request.dart';
import '../../sign_in_screen/model/login_model.dart';

class OtpController extends GetxController {
  LoginUserModel loginUserModel = LoginUserModel();
  User updateUser = User();
  RxString errorMessage = "".obs;
  RxInt secondsRemaining = 30.obs;
  RxBool enableResend = false.obs;

  Future fetchOtp(String otp, String name, String number, String greet,
      String? verificationId, BuildContext context) async {
    try {
      // Auth.FirebaseAuth auth = Auth.FirebaseAuth.instance;
      // if (verificationId != null) {
      //   logger.d("Trying firebase logging with : $verificationId");
      //   Auth.PhoneAuthCredential credential =
      //   Auth.PhoneAuthProvider.credential(
      //     verificationId: verificationId, smsCode: otp,
      //   );
      //   Auth.UserCredential creds = await auth.signInWithCredential(credential);
      //   logger.d("retrieved cred from Firebase: ${creds.user?.phoneNumber ?? "No Number Here"}");
      // }
      var validation = await LoginRepo.otpVerify(otp, number) as LoginUserModel;
      if (validation != null) {
        loginUserModel == validation;
        nameUpdate(name, greet);
        // Get.off(NameUpdateScreen());
      } else {}
    } on ServiceException catch (e) {
      logger.e(e.message);
      errorMessage.value = e.message!;
      showSnackBar(context, e.message);
    }
    // on Auth.FirebaseAuthException catch (e) {
    //   logger.e(e.message);
    //   errorMessage.value = e.code;
    //   showSnackBar(context, e.message);
    //   rethrow;
    // }
    catch (e) {
      logger.d(e);
      showSnackBar(context, Strings.someThingWentWrong);
    }
  }

  Future<bool> nameUpdate(String updateName, String greet,
      {bool isNew = true}) async {
    try {
      // Analytics analytics = Analytics();
      var profileUpdate = await ProfileRepo.updateProfile(
          NameUpdateRequestModel(name: updateName, greeting: greet)) as User;
      if (profileUpdate != null) {
        updateUser = profileUpdate;
        if (isNew) {
          var checkLogin = await SharedPref.getBoolVal();
          var getRouts = await SharedPref.getRoutes();
          if (checkLogin == true || getRouts == null) {
            // Get.off(() => MapScreen(mapRole: MapRole.homePopUp));
          } else {
            // AppRoutes.offAllNamed(getRouts);
            // Get.off(() => const HomeScreen());
          }
          Get.off(() => const HomeScreen());
          // analytics.trackEvent(TrackingEvent.signupComplete, {...profileUpdate.toJson(), "PhoneNumber": profileUpdate.phoneNumber});
        }
        return true;
      } else {
        print("number screen :${Strings.someThingWentWrong}");
        return false;
      }
    } on RepoServiceException catch (e) {
      logger.e(e.message);
      errorMessage.value = e.message!;
      return false;
    }
  }

  resetSeconds() {
    enableResend.value = false;
    secondsRemaining.value = 30;
  }

// Future updateDeiceDetail() async {
//   try {
//     var validation = await ConfigRepo.updateDeviceDetails(deviceDetailsRequest);
//     if (validation != null) {
//
//       Get.to(const NameUpdateScreen());
//     } else {}
//   } catch (error) {
//     logger.e(error);
//   }
// }

  showSnackBar(BuildContext context, message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
