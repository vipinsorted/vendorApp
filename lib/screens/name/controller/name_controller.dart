import 'package:get/get.dart';

import '../../../logger.dart';
import '../../../network/service_exception.dart';
import '../../../repo/profile_repo.dart';
import '../../../strings.dart';
import '../../sign_in_screen/model/login_model.dart';
import '../model/name_update_request.dart';

class NameUpdateController extends GetxController {
  User updateUser = User();
  RxString errorMessage = "".obs;
  Future nameUpdate(String updateName) async {
    try {
      var profileUpdate = await ProfileRepo.updateProfile(
          NameUpdateRequestModel(name: updateName)) as User;
      if (profileUpdate != null) {
        updateUser = profileUpdate;
        // Get.off(() =>  MapScreen());
        // Get.off(() =>  LocationMiddlewareScreen());
        // Get.off(() =>  NewOtpScreen());
      } else {
        print("number screen :${Strings.someThingWentWrong}");
      }
    } on RepoServiceException catch (e) {
      logger.e(e.message);
      errorMessage.value = e.message!;
    }
  }
}
