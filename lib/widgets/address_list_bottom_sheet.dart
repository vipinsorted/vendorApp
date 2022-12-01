// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
//
// import '../network/shared_prefs.dart';
//
// class AddressListBottomSheet {
//   static TextEditingController searchController = TextEditingController();
//   static AddressListController addressListController =
//       Get.put(AddressListController());
//   static late StateSetter? bottomSheetState;
//   static String address = Strings.setAddress;
//
//   static showAddressListBottomSheet(
//       {required ValueChanged onChange,
//       required VoidCallback clear,
//       required String addr}) {
//     address = addr;
//     Get.bottomSheet(
//         isScrollControlled: true,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             topLeft: Corners.lgRadius * 4,
//             topRight: Corners.lgRadius * 4,
//           ),
//         ),
//         backgroundColor: AppTheme.containerWhite,
//         StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
//       bottomSheetState = setState;
//       return Container(
//         padding: EdgeInsets.only(
//             top: Insets.lg + 6,
//             right: Insets.lg + 8,
//             left: Insets.med,
//             bottom: Insets.xxl),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     Get.back();
//                   },
//                   icon: Icon(Icons.arrow_back,
//                       color: AppTheme.iconColor, size: Insets.lg * 1.5),
//                 ),
//                 Expanded(
//                   child: SearchWidget(
//                     onChange: onChange,
//                     onTapClear: () {
//                       clear;
//                       bottomSheetState!(() {});
//                       searchController.clear();
//                     },
//                     hintText: "Search for area, street name",
//                     prefixIcon: Icons.search,
//                     isSuffixIcon: true,
//                     textEditingController: searchController,
//                     textInputType: TextInputType.text,
//                   ),
//                 )
//               ],
//             ),
//             Container(
//                 margin: EdgeInsets.only(
//                     top: Insets.lg,
//                     bottom: Insets.lg,
//                     left: Insets.xxl + 10,
//                     right: Insets.xs),
//                 child: Row(
//                   children: [
//                     const Icon(Icons.my_location_sharp,
//                         size: 20, color: AppTheme.buttonColor),
//                     SizedBox(width: Insets.med),
//                     Expanded(
//                       flex: 5,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Your current location",
//                               style: TextStyles.primary.copyWith(
//                                   fontFamily: "Roboto",
//                                   fontSize: 12,
//                                   color: AppTheme.iconColor.withOpacity(0.6))),
//                           SizedBox(height: Insets.xs),
//                           Text(address,
//                               style: TextStyles.primary.copyWith(
//                                 fontFamily: "Roboto",
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                               ))
//                         ],
//                       ),
//                     ),
//                     const Spacer(),
//                     IconButton(
//                       onPressed: () {
//                         Get.to(MapScreen(
//                           mapRole: MapRole.changeCurrentLocation,
//                           // pageLocation: PageLocation.searchPage,
//                         ));
//                       },
//                       icon: const Icon(Icons.arrow_forward,
//                           color: AppTheme.iconColor, size: 20),
//                     )
//                   ],
//                 )),
//             const Divider(height: 0.2, thickness: 0.4, color: AppTheme.grey),
//             SizedBox(height: Insets.lg),
//             Padding(
//               padding: EdgeInsets.only(
//                   top: Insets.med, left: Insets.xl, bottom: Insets.sm),
//               child: Text("MY ADDRESS",
//                   style: TextStyles.primary.copyWith(
//                       fontWeight: FontWeight.bold,
//                       fontFamily: "Open Sans",
//                       fontSize: 10,
//                       color: AppTheme.grey)),
//             ),
//             Obx(
//               () => SizedBox(
//                 height: 150.0,
//                 child: ListView.separated(
//                   shrinkWrap: true,
//                   physics: const ScrollPhysics(),
//                   itemCount: addressListController.filteredList.length,
//                   itemBuilder: (context, index) {
//                     return InkWell(
//                       onTap: () async {
//                         CurrentAddressModel currentAddressModel =
//                             CurrentAddressModel(
//                                 latitude: addressListController
//                                     .filteredList[index].lat,
//                                 longitude: addressListController
//                                     .filteredList[index].lng,
//                                 placeName:
//                                     "${addressListController.filteredList[index].addressLine1} - ${addressListController.filteredList[index].city} - ${addressListController.filteredList[index].pincode}");
//                         await SharedPref.setCurrentAddress(currentAddressModel);
//                         updateDeliveryAdd();
//                       },
//                       child: Padding(
//                         padding: EdgeInsets.only(
//                             top: Insets.sm,
//                             left: Insets.xl,
//                             bottom: Insets.med),
//                         child: Row(children: [
//                           svgIcon(index),
//                           SizedBox(width: Insets.med),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                     addressListController
//                                         .filteredList[index].type
//                                         .toString(),
//                                     style: TextStyles.primary.copyWith(
//                                         fontFamily: "Roboto",
//                                         color: AppTheme.black,
//                                         fontWeight: FontWeight.bold)),
//                                 SizedBox(height: Insets.xs),
//                                 Text(
//                                     "${addressListController.filteredList[index].addressLine1} - ${addressListController.filteredList[index].city} - ${addressListController.filteredList[index].pincode}",
//                                     style: TextStyles.primary.copyWith(
//                                         fontFamily: "Roboto",
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w400))
//                               ],
//                             ),
//                           ),
//                         ]),
//                       ),
//                     );
//                   },
//                   separatorBuilder: (context, index) {
//                     return const Divider(
//                         height: 0.2, thickness: 0.4, color: AppTheme.grey);
//                   },
//                 ),
//               ),
//             ),
//             const Divider(height: 0.2, thickness: 0.4, color: AppTheme.grey),
//             const SizedBox(),
//             Align(
//               alignment: Alignment.center,
//               child: InkWell(
//                 onTap: () {
//                   Get.to(MapScreen(
//                     // pageLocation: PageLocation.homePage,
//                     mapRole: MapRole.addAddress,
//                   ));
//                   setState(() {});
//                 },
//                 child: Container(
//                   margin: EdgeInsets.only(top: Insets.xl),
//                   height: 40,
//                   width: 188,
//                   decoration: BoxDecoration(
//                       color: AppTheme.white,
//                       border: Border.all(color: AppTheme.buttonColor, width: 1),
//                       borderRadius: Corners.avatarShadowBorder),
//                   child: (Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SvgPicture.asset("assets/images/building_icon.svg"),
//                       SizedBox(width: Insets.xs),
//                       Text(
//                         Strings.addNewButton,
//                         style: TextStyles.primary
//                             .copyWith(color: AppTheme.buttonColor),
//                       )
//                     ],
//                   )),
//                 ),
//               ),
//             )
//           ],
//         ),
//       );
//     }));
//   }
//
//   static Widget svgIcon(index) {
//     if (addressListController.filteredList[index].type.toString() == "Home" ||
//         addressListController.filteredList[index].type.toString() == "Other") {
//       return SvgPicture.asset("assets/images/home.svg", height: 20);
//     } else if (addressListController.filteredList[index].type.toString() ==
//         "Work") {
//       return SvgPicture.asset("assets/images/bag_icon.svg",
//           height: 20, color: AppTheme.red);
//     } else {
//       return SvgPicture.asset("assets/images/home.svg", height: 20);
//     }
//   }
//
//   static updateDeliveryAdd() async {
//     CurrentAddressModel? addressDetail = await SharedPref.getCurrentAddress();
//     address = addressDetail!.placeName ?? Strings.setAddress;
//     if (bottomSheetState == null) return;
//     bottomSheetState!(() {});
//   }
// }
