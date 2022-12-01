import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../logger.dart';
import '../../../network/service_exception.dart';
import '../../../network/shared_prefs.dart';
import '../../../repo/config_repo.dart';
import '../../../strings.dart';
import '../model/init_config_response.dart';

class ConfigController {
  static const String baseUrl = "base_url";
  RxString errorMessage = "".obs;
  RxList<String> sortingData = <String>[].obs;

  Future getInitConfig() async {
    try {
      InitConfigResponse? configResponse = await ConfigRepo.getInitConfig();
      if (configResponse != null) {
        SharedPref.setStringWithKey(
            SharedPref.baseUrl, configResponse.config!.cdnBaseUrl!);
        SharedPref.setStringWithKey(
            SharedPref.storyBaseUrl, configResponse.config!.storyBaseUrl!);
        SharedPref.setStringWithKey(SharedPref.CALL_TO_ORDER_NUMBER,
            configResponse.config!.callToOrderNumber!);
        SharedPref.setStringWithKey(
            SharedPref.WHATSAPP_NUMBER, configResponse.config!.whatsAppNumber!);
        SharedPref.setStringWithKey(
            SharedPref.HELP_NUMBER, configResponse.config!.helpNumber!);
        SharedPref.setStringWithKey(SharedPref.TERMS_AND_CONDITION,
            configResponse.config!.termsAndConditions!);
        SharedPref.setStringWithKey(
            SharedPref.PRIVACY_POLICY, configResponse.config!.privacyPolicy!);
        SharedPref.setBoolWithKey(SharedPref.IS_FIREBASE_ENABLED,
           configResponse.config!.isFirebaseEnabled!);
        SharedPref.setStringWithKey(SharedPref.MIN_IMAGE_URL,
            configResponse.config!.minImageUrl!);
        sortingData.value = configResponse.config?.homePageSortList ?? [];
      } else {
        logger.d("geoCoordinatesAPI  :${Strings.someThingWentWrong}");
      }
    } on RepoServiceException catch (e) {
      logger.e(e.message);
      errorMessage.value = e.message!;
    }
  }
}
