// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import '../../../logger.dart';
import '../../../network/service_exception.dart';
import '../../../repo/login_repo.dart';
import '../../../routes/app_routes.dart';
import '../../../strings.dart';
import '../../name/screen/new_name_screen.dart';
import '../../otp_screen/screen/otp_screen.dart';
import '../model/number_validation_model.dart';

class NumberValidationController extends GetxController {
  NumberValidation numberValidation = NumberValidation();

  RxString errorMessage = "".obs;

  late BuildContext _context;
  // FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void setContext(BuildContext context) {
    _context = context;
  }

  Future fetchOtp(String number, String? verificationId, BuildContext context,
      {bool isNavigate = true}) async {
    try {
      var validation = await LoginRepo.numberValidation(number)
          as NumberValidation;
      if (validation != null) {
        numberValidation = validation;
        if (isNavigate) {
          if (numberValidation.isNewUser) {
            Navigator.pushAndRemoveUntil(
                _context,
                PageTransition(
                    child: NewNameScreen(number: number),
                    duration: const Duration(seconds: 1),
                    type: PageTransitionType.fade),ModalRoute.withName(Routes.splashScreen));
          } else {
            Navigator.pushAndRemoveUntil(
                _context,
                PageTransition(
                    child: NewOtpScreen(
                      greetings: 'Hey',
                      name: numberValidation.name.toString(),
                      isUserFound: true,
                      number: number,
                      verificationId: verificationId,
                    ),
                    duration: const Duration(seconds: 1),
                    type: PageTransitionType.fade),ModalRoute.withName(Routes.splashScreen));
          }
        }

      } else {
        logger.d("number screen :${Strings.someThingWentWrong}");
      }
    } on RepoServiceException catch (e) {
      logger.e(e.message);
      errorMessage.value = e.message!;
      showSnackBar(context, e.message);
    } catch (e) {
      showSnackBar(context, Strings.someThingWentWrong);
    }
  }

  // Future loginWithFirebase(String mobileNumber, BuildContext context) async {
  //   verificationComplete(PhoneAuthCredential credential) {
  //     firebaseAuth.signInWithCredential(credential);
  //   }
  //
  //   verificationFailed(FirebaseAuthException e) {
  //     logger.e(e, e);
  //     errorMessage.value = e.code;
  //     // showSnackBar(context, e.code);
  //     fetchOtp(mobileNumber, null, context);
  //   }
  //
  //   codeSend(String verificationId, int? resendToken) {
  //     fetchOtp(mobileNumber, verificationId, context);
  //   }
  //
  //   try {
  //     await firebaseAuth.verifyPhoneNumber(
  //       phoneNumber: '+91$mobileNumber',
  //       verificationCompleted: verificationComplete,
  //       verificationFailed: verificationFailed,
  //       codeSent: codeSend,
  //       codeAutoRetrievalTimeout: (String verificationId) {},
  //     );
  //   } on FirebaseException catch (e) {
  //     logger.e(e);
  //     showSnackBar(context, e.message);
  //   } catch (e) {
  //     showSnackBar(context, Strings.someThingWentWrong);
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
