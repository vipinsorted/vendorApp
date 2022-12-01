// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../network/shared_prefs.dart';
// import '../../../routes/app_routes.dart';
// import '../../../strings.dart';
// import '../../../themes.dart';
// import '../../../widgets/new_permission_dialog.dart';
//
// class LoginPopup extends StatefulWidget {
//   const LoginPopup({Key? key}) : super(key: key);
//
//   @override
//   State<LoginPopup> createState() => _LoginPopupState();
// }
//
// class _LoginPopupState extends State<LoginPopup> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     loginPopup();
//     return Scaffold(
//       backgroundColor: AppTheme.white,
//       body: Container(),
//     );
//   }
//
//   void loginPopup() async {
//     String routes = Routes.homeScreen;
//     await SharedPref.setRoutes(routes);
//     NewPermissionPopup.getPopup(
//       image: "assets/images/lock_popup.svg",
//       title: "",
//       heading: Strings.loginNow,
//       label:Strings.notLoginMsg,
//       buttonNameAllow: Strings.loginNow,
//       buttonNameDeny: Strings.cancel,
//       buttonIconAllow: Icons.login_outlined,
//       buttonIconDeny: Icons.close,
//       buttonIconAllowImage: "assets/images/login_door.svg",
//       allowTap: (){
//         AppRoutes.toNamed(Routes.newMobileScreen);
//       },
//       denyTap: (){
//         Get.back();
//         Get.back();
//       },
//     );
//     // CheckLoginBox.getPopup(
//     //     denyTap: () {
//     //       Get.back();
//     //       Get.back();
//     //     },
//     //     allowTap: () {
//     //       AppRoutes.toNamed(Routes.newMobileScreen);
//     //     },
//     //     heading: Strings.loginNow,
//     //     buttonNameAllow: Strings.loginNow,
//     //     buttonNameDeny: Strings.cancel,
//     //     label: Strings.notLoginMsg);
//   }
// }
