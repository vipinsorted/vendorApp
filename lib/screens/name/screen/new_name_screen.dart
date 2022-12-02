// // ignore_for_file: must_be_immutable
//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:scroll_snap_list/scroll_snap_list.dart';
//
// import '../../../network/shared_prefs.dart';
// import '../../../routes/app_routes.dart';
// import '../../../strings.dart';
// import '../../../styles.dart';
// import '../../../themes.dart';
// import '../../number_validation_screen/controller/number_validation_controller.dart';
// import '../../number_validation_screen/widget/custom_number_text_field.dart';
// import '../../otp_screen/controller/verify_otp_controller.dart';
// import '../../otp_screen/screen/otp_screen.dart';
// import '../../sign_in_screen/model/login_model.dart';
// import '../controller/name_controller.dart';
//
// class NewNameScreen extends StatefulWidget {
//   NewNameScreen({
//     Key? key,
//     this.number,
//     this.name,
//     this.isUpdateName = false,
//     this.greeting,
//     this.verificationId,
//   }) : super(key: key);
//
//   String? number;
//   String? name;
//   String? greeting;
//   bool isUpdateName;
//   String? verificationId;
//
//   @override
//   State<NewNameScreen> createState() => _NewNameScreenState();
// }
//
// class _NewNameScreenState extends State<NewNameScreen>
//     with TickerProviderStateMixin {
//   double opacity = 0.0;
//   String number = '';
//   String name = '';
//   String selectedGreeting = 'Hi';
//
//   bool _isUserNumberAnimation = false;
//   bool _isUserGreetingAnimation = false;
//   bool _isUserGreetingTextAnimation = false;
//   bool _isUserSliderAnimation = false;
//   bool _isUserInputAnimation = false;
//
//   TextEditingController firstNameController = TextEditingController();
//   TextEditingController lastNameController = TextEditingController();
//   TextEditingController numberEditController = TextEditingController();
//   NameUpdateController nameUpdateController = Get.put(NameUpdateController());
//
//   final TextEditingController _firstNumberController = TextEditingController();
//   final TextEditingController _secondNumberController = TextEditingController();
//   final TextEditingController _thirdNumberController = TextEditingController();
//
//   late FocusNode first4Number;
//   late FocusNode second3Number;
//   late FocusNode third3Number;
//   late FocusNode firstName;
//
//   NumberValidationController numberValidationController =
//       Get.put(NumberValidationController());
//   OtpController otpController = Get.put(OtpController());
//   bool isFirstTime = false;
//   List greeting = ["Hi", "Hello", "Hey", "Dear"];
//
//   getNumber() async {
//     number = widget.number ?? "";
//     name = widget.name ?? "";
//     selectedGreeting = widget.greeting ?? "Hi";
//
//     _firstNumberController.text = widget.number!.substring(0, 4);
//     _secondNumberController.text = widget.number!.substring(4, 7);
//     _thirdNumberController.text = widget.number!.substring(7, 10);
//
//     first4Number = FocusNode();
//     second3Number = FocusNode();
//     third3Number = FocusNode();
//     firstName = FocusNode();
//
//     List<String> naming = name.split(" ");
//     firstNameController.text = naming[0];
//     lastNameController.text = naming[1];
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getNumber();
//     startTimer();
//     // animation();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     firstNameController.dispose();
//     lastNameController.dispose();
//     numberEditController.dispose();
//   }
//
//   void startTimer() {
//     Future.delayed(const Duration(milliseconds: 500), () {
//       _isUserNumberAnimation = true;
//       setState(() {});
//       Future.delayed(const Duration(milliseconds: 500), () {
//         _isUserGreetingAnimation = true;
//         setState(() {});
//         Future.delayed(const Duration(milliseconds: 500), () {
//           _isUserGreetingTextAnimation = true;
//           setState(() {});
//           Future.delayed(const Duration(milliseconds: 500), () {
//             _isUserSliderAnimation = true;
//             setState(() {});
//             Future.delayed(const Duration(milliseconds: 500), () {
//               _isUserInputAnimation = true;
//               firstName.requestFocus();
//               setState(() {});
//             });
//           });
//         });
//       });
//     });
//   }
//
//   changeOpacity() {
//     if (isFirstTime) return;
//     isFirstTime = true;
//     Future.delayed(const Duration(milliseconds: 100), () {
//       setState(() {
//         opacity = 1.0;
//         setState(() {});
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     changeOpacity();
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: SizedBox(
//             width: double.infinity,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(height: Insets.xxl),
//                 widget.isUpdateName
//                     ? Padding(
//                         padding: EdgeInsets.only(left: Insets.lg),
//                         child: Align(
//                           alignment: Alignment.topLeft,
//                           child: InkWell(
//                             onTap: () {
//                               AppRoutes.back();
//                             },
//                             child: const Icon(Icons.arrow_back),
//                           ),
//                         ),
//                       )
//                     : const SizedBox(),
//                 SvgPicture.asset("assets/images/sorted_logo_squared.svg", height: 60),
//                 SizedBox(height: Insets.xxl + 4),
//                 userNumber(),
//                 SizedBox(height: Insets.xxl),
//                 userGreeting(),
//                 SizedBox(height: Insets.sm),
//                 greetText(),
//                 SizedBox(height: Insets.xl),
//                 slider(),
//                 SizedBox(height: Insets.xl),
//                 userInput(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget userInput() => AnimatedOpacity(
//         duration: const Duration(milliseconds: 500),
//         opacity: _isUserInputAnimation ? 1.0 : 0.0,
//         child: Container(
//           padding: EdgeInsets.only(left: Insets.xl, right: Insets.xl),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(top: Insets.sm),
//                 child: Row(
//                   children: [
//                     Text(
//                       selectedGreeting,
//                       style: TextStyles.primary.copyWith(
//                           color: AppTheme.darkYellow,
//                           fontSize: 18,
//                           fontWeight: FontWeight.w400),
//                     )
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   decoration: const BoxDecoration(
//                       border: Border(
//                           bottom: BorderSide(
//                               width: 2, color: AppTheme.darkYellow))),
//                   child: Hero(
//                     tag: "firstName",
//                     child: AnimatedOpacity(
//                       duration: const Duration(milliseconds: 1500),
//                       opacity: opacity,
//                       child: TextField(
//                         textInputAction: TextInputAction.next,
//                         controller: firstNameController,
//                         textAlign: TextAlign.start,
//                         focusNode: firstName,
//                         decoration: InputDecoration(
//                           hintText: "Kishor",
//                           hintStyle: TextStyle(
//                             color: Colors.grey.shade400,
//                           ),
//                           contentPadding: EdgeInsets.only(
//                               top: Insets.med,
//                               left: Insets.med,
//                               right: Insets.med),
//                           border: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(width: Insets.med),
//               Expanded(
//                 child: Container(
//                   decoration: const BoxDecoration(
//                       border: Border(
//                           bottom: BorderSide(
//                               width: 2, color: AppTheme.darkYellow))),
//                   child: Hero(
//                     tag: "lastName",
//                     child: AnimatedOpacity(
//                       duration: const Duration(milliseconds: 1500),
//                       opacity: opacity,
//                       child: TextField(
//                         onSubmitted: (name) {
//                           submitOtp();
//                         },
//                         controller: lastNameController,
//                         decoration: InputDecoration(
//                           hintText: "Kumar",
//                           hintStyle: TextStyle(
//                             color: Colors.grey.shade400,
//                           ),
//                           contentPadding: EdgeInsets.only(
//                               top: Insets.med,
//                               left: Insets.med,
//                               right: Insets.med),
//                           border: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//
//   Widget greetText() => AnimatedOpacity(
//         duration: const Duration(milliseconds: 500),
//         opacity: _isUserGreetingTextAnimation ? 1.0 : 0.0,
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: Insets.xxl * 2.5),
//           child: AnimatedOpacity(
//             duration: const Duration(milliseconds: 1500),
//             opacity: opacity,
//             child: Text(
//               Strings.greetYou,
//               maxLines: 2,
//               textAlign: TextAlign.center,
//               style: TextStyles.primary
//                   .copyWith(fontSize: 18, height: 1.3, color: AppTheme.black),
//             ),
//           ),
//         ),
//       );
//
//   Widget userNumber() => AnimatedOpacity(
//         duration: const Duration(milliseconds: 500),
//         opacity: _isUserNumberAnimation ? 1.0 : 0.0,
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//               horizontal: itemSizeByParam(context, ratio: 0.1)),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const Text(
//                 Strings.number91,
//                 textAlign: TextAlign.right,
//                 style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.w400,
//                     color: AppTheme.darkYellow,
//                     height: 2.5),
//               ),
//               SizedBox(width: Insets.xs),
//               Expanded(
//                   flex: 4,
//                   child: CustomNumberTextField(
//                     fontSize: 28.0,
//                     focusNode: first4Number,
//                     maxLength: 4,
//                     onChanged: (val) {
//                       if (val.length == 4) {
//                         second3Number.requestFocus();
//                       }
//                     },
//                     controller: _firstNumberController,
//                   )),
//               SizedBox(width: Insets.sm),
//               Expanded(
//                   flex: 3,
//                   child: CustomNumberTextField(
//                     fontSize: 28.0,
//                     focusNode: second3Number,
//                     maxLength: 3,
//                     onChanged: (val) {
//                       if (val.length == 3) {
//                         third3Number.requestFocus();
//                       } else if (val.length == 0) {
//                         first4Number.requestFocus();
//                       }
//                     },
//                     controller: _secondNumberController,
//                   )),
//               SizedBox(width: Insets.sm),
//               Expanded(
//                   flex: 3,
//                   child: CustomNumberTextField(
//                     fontSize: 28.0,
//                     focusNode: third3Number,
//                     maxLength: 3,
//                     onChanged: (val) {
//                       if (val.length == 0) {
//                         second3Number.requestFocus();
//                       }
//                     },
//                     controller: _thirdNumberController,
//                   )),
//               Padding(
//                 padding: EdgeInsets.only(top: Insets.lg, left: Insets.xs),
//                 child: InkWell(
//                     onTap: () {
//                       third3Number.requestFocus();
//                     },
//                     child: const Icon(Icons.create_outlined,
//                         color: AppTheme.darkYellow)),
//               )
//             ],
//           ),
//         ),
//       );
//
//   Widget userGreeting() => AnimatedOpacity(
//         duration: const Duration(milliseconds: 500),
//         opacity: _isUserGreetingAnimation ? 1.0 : 0.0,
//         child: Text(
//           Strings.helloStrangers,
//           style: TextStyles.primary.copyWith(
//               fontSize: 24, color: Colors.black, fontWeight: FontWeight.w700),
//         ),
//       );
//
//   Widget slider() {
//     return AnimatedOpacity(
//       duration: const Duration(milliseconds: 500),
//       opacity: _isUserSliderAnimation ? 1.0 : 0.0,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(
//             height: (Insets.xl * 1.2),
//             child: Stack(
//               alignment: Alignment.center,
//               clipBehavior: Clip.none,
//               children: [
//                 Center(
//                   child: Container(
//                     height: (Insets.xl * 1),
//                     width: itemSize(context),
//                     padding: EdgeInsets.symmetric(horizontal: Insets.med),
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: AppTheme.buttonColor,
//                         width: 2,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Center(
//                   child: Container(
//                     width: (itemSize(context)) * 0.8,
//                     padding: EdgeInsets.symmetric(horizontal: Insets.med),
//                     decoration: const BoxDecoration(
//                         border: Border.symmetric(
//                             horizontal: BorderSide(
//                           color: AppTheme.containerWhite,
//                           width: 2,
//                         )),
//                         color: AppTheme.containerWhite),
//                   ),
//                 ),
//                 ScrollSnapList(
//                   padding: EdgeInsets.zero,
//                   focusOnItemTap: true,
//                   dynamicItemOpacity: 0.7,
//                   dynamicItemSize: true,
//                   dynamicSizeEquation: (d) {
//                     if (d.abs() > ((itemSize(context)) / 3)) {
//                       return 0.8; //Needs to be calculated
//                     }
//                     return 1;
//                   },
//                   itemSize: itemSize(context),
//                   itemCount: greeting.length,
//                   onItemFocus: (index) {
//                     selectedGreeting = greeting[index];
//                     setState(() {});
//                   },
//                   itemBuilder: (context, index) {
//                     return SizedBox(
//                       width: itemSize(context),
//                       child: Center(
//                         child: SizedBox(
//                           width: (itemSize(context)) * .8,
//                           height: (Insets.xl * 1.2),
//                           child: Center(
//                             child: Text(
//                               greeting[index],
//                               style: TextStyles.title2.copyWith(
//                                 fontSize: selectedGreeting == greeting[index]
//                                     ? FontSizes.s16
//                                     : FontSizes.s14,
//                                 fontWeight: selectedGreeting == greeting[index]
//                                     ? FontWeight.bold
//                                     : FontWeight.normal,
//                                 color: selectedGreeting == greeting[index]
//                                     ? AppTheme.buttonColor
//                                     : AppTheme.iconColor,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   submitOtp() async {
//     var fullName = "${firstNameController.text} ${lastNameController.text}";
//     User? user = await SharedPref.getCurrentUser();
//     user!.name = fullName;
//     if (widget.isUpdateName) {
//       bool isSuccess =
//           await otpController.nameUpdate(fullName, "Hey", isNew: false);
//       if (isSuccess) {
//         await SharedPref.setCurrentUser(user);
//       }
//     } else {
//       // ignore: use_build_context_synchronously
//       Navigator.push(
//           context,
//           PageTransition(
//               child: NewOtpScreen(
//                 number: getFullNumber(),
//                 name: fullName,
//                 greetings: selectedGreeting,
//                 verificationId: widget.verificationId,
//               ),
//               duration: const Duration(milliseconds: 1000),
//               type: PageTransitionType.fade));
//     }
//     firstNameController.clear();
//     lastNameController.clear();
//   }
//
//   String getFullNumber() =>
//       _firstNumberController.text +
//       _secondNumberController.text +
//       _thirdNumberController.text;
//
//   double itemSizeByParam(BuildContext context, {double ratio = 1.0}) =>
//       context.width * ratio;
//
//   double itemSize(BuildContext context) => context.width * 0.22;
// }
