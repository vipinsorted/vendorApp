import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vendor_app/widgets/small_custom_button.dart';

import '../strings.dart' show Strings;
import '../styles.dart';
import '../themes.dart';
import 'custom_address_button.dart';
import 'custom_button.dart';
import 'custom_text_field.dart';

class CustomBottomSheet {
  static int selectIndex = 0;
  static List<String> addressButtonList = [
    Strings.home,
    Strings.office,
    Strings.others
  ];

  static TextEditingController houseController = TextEditingController();
  static TextEditingController apartmentController = TextEditingController();
  static TextEditingController landmarkController = TextEditingController();

  // static void setFields(ReceiveConsumerAddress address) {
  //   houseController.text = address.addressLine1 ?? "";
  //   apartmentController.text = address.addressLine2 ?? "";
  //   landmarkController.text = address.landmark ?? "";
  //
  //   if (address.type == "Home") {
  //     selectIndex = 0;
  //   } else if (address.type == "Work") {
  //     selectIndex = 1;
  //   } else if (address.type == "Other") {
  //     selectIndex = 2;
  //   }
  // }

  static void _clearFields() {
    houseController.text = "";
    apartmentController.text = "";
    landmarkController.text = "";
    selectIndex = 0;
  }

  static showAddEditAddressShit(
      {required Function onConfirmPressed,
      Function? onChange,
      String? currentAddress}) {
    Get.bottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Corners.lgRadius * 4,
            topRight: Corners.lgRadius * 4,
          ),
        ),
        backgroundColor: AppTheme.containerWhite, StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Container(
            padding: EdgeInsets.only(
                top: Insets.xxl,
                left: Insets.xs * 5,
                right: Insets.xs * 5,
                bottom: Insets.xs * 2.5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset("assets/images/location_icon.svg",
                        color: AppTheme.buttonColor),
                    SizedBox(width: Insets.xs + 2),
                    Expanded(
                      child: Text(
                        currentAddress ?? "",
                        style: TextStyles.primary.copyWith(
                            fontWeight: FontWeight.w600,
                            fontFamily: "Roboto",
                            fontSize: 14,
                            color: AppTheme.black.withOpacity(0.7)),
                      ),
                    ),
                    smallCustomButton(
                      text: Strings.change,
                      onTap: () {
                        onChange!();
                      },
                    )
                  ],
                ),
                SizedBox(height: Insets.lg + 10),
                CustomTextField(
                  controller: houseController,
                  hintText: Strings.houseAddress,
                ),
                CustomTextField(
                    controller: apartmentController,
                    hintText: Strings.apartmentAddress),
                CustomTextField(
                    controller: landmarkController, hintText: Strings.landmark),
                SizedBox(height: Insets.med),
                Padding(
                  padding: EdgeInsets.only(
                      left: Insets.lg, top: Insets.xs, bottom: Insets.xs),
                  child: Text(Strings.setAddress,
                      style: TextStyles.primary.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppTheme.grey,
                          fontSize: 12)),
                ),
                Row(
                  children: [
                    CustomAddressButton(
                        svgColor:
                            selectIndex == 0 ? AppTheme.white : AppTheme.grey,
                        svgPicture: "assets/images/home_icon.svg",
                        showIcon: true,
                        color: selectIndex == 0 ? AppTheme.red : AppTheme.white,
                        text: addressButtonList[0],
                        textColor:
                            selectIndex == 0 ? AppTheme.white : AppTheme.grey,
                        onTap: () {
                          setState(() {
                            selectIndex = 0;
                          });
                        }),
                    CustomAddressButton(
                        svgPicture: "assets/images/bag_icon.svg",
                        svgColor:
                            selectIndex == 1 ? AppTheme.white : AppTheme.grey,
                        showIcon: true,
                        color: selectIndex == 1 ? AppTheme.red : AppTheme.white,
                        text: addressButtonList[1],
                        textColor:
                            selectIndex == 1 ? AppTheme.white : AppTheme.grey,
                        onTap: () {
                          setState(() {
                            selectIndex = 1;
                          });
                        }),
                    CustomAddressButton(
                        color: selectIndex == 2 ? AppTheme.red : AppTheme.white,
                        text: addressButtonList[2],
                        textColor:
                            selectIndex == 2 ? AppTheme.white : AppTheme.grey,
                        onTap: () {
                          setState(() {
                            selectIndex = 2;
                          });
                        })
                  ],
                ),
                SizedBox(height: Insets.xl),
                CustomButton(
                    onTap: () {
                      onConfirmPressed(
                        houseController.value.text.trim(),
                        apartmentController.value.text.trim(),
                        landmarkController.value.text.trim(),
                        selectIndex,
                      );
                      _clearFields();
                    },
                    name: Strings.confirmAddress),
                SizedBox(height: Insets.lg + 4)
              ],
            ));
      },
    ));
  }
}
