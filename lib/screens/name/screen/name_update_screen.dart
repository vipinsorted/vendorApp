import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../strings.dart';
import '../../../styles.dart';
import '../../../themes.dart';
import '../../../widgets/custom_button.dart';
import '../controller/name_controller.dart';

class NameUpdateScreen extends StatefulWidget {
  const NameUpdateScreen({Key? key}) : super(key: key);

  @override
  State<NameUpdateScreen> createState() => _NameUpdateScreenState();
}

class _NameUpdateScreenState extends State<NameUpdateScreen> {
  NameUpdateController nameUpdateController = Get.put(NameUpdateController());
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }

  //body part
  Widget _buildBody() => Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [AppTheme.backgroundGradient, AppTheme.white],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter)),
        child: Stack(
          children: [
            headerPart(),
            bottomPart(),
          ],
        ),
      );

  // background image
  Widget headerPart() => Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [AppTheme.backgroundGradient, AppTheme.white],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter)),
        padding: EdgeInsets.only(
            left: Insets.xs * 5, right: Insets.xs * 5, top: Insets.xs * 2.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: Insets.sm * 7.5),
            SvgPicture.asset("assets/images/logo.svg",
                fit: BoxFit.cover, height: Insets.sm * 10),
            SizedBox(height: Insets.xs * 12.5),
          ],
        ),
      );

  //textField and button container
  Widget bottomPart() => Positioned(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25.0, sigmaY: 25.0),
              child: Container(
                  padding: EdgeInsets.only(
                      left: Insets.med + 2,
                      right: Insets.med + 2,
                      top: Insets.xs * 5,
                      bottom: Insets.xs * 2.5),
                  margin: EdgeInsets.only(
                      left: Insets.med + 2,
                      right: Insets.med + 2,
                      top: Insets.xs * 5,
                      bottom: Insets.xs * 2.5),
                  width: double.infinity,
                  height: Insets.xxl * 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(Strings.whatShallICallYou,
                          textAlign: TextAlign.center,
                          style: TextStyles.primary.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w300)),
                      SizedBox(height: Insets.med * 3),
                      textField(),
                      SizedBox(height: Insets.med * 3),
                      CustomButton(
                          name: Strings.sortedButton,
                          onTap: () async {
                            if (_nameController.text.isEmpty) {
                              Fluttertoast.showToast(msg: Strings.enterName);
                              return;
                            } else {
                              nameUpdateController
                                  .nameUpdate(_nameController.text);
                              _nameController.clear();
                            }
                          }),
                      SizedBox(height: Insets.xs * 2.5),
                    ],
                  )),
            ),
          ),
        ),
      );

  //textField
  Widget textField() => TextField(
      controller: _nameController,
      keyboardType: TextInputType.text,
      style: TextStyle(
        fontSize: FontSizes.s28, // This is not so important
      ),
      textAlign: TextAlign.center,
      decoration: const InputDecoration(
        hintText: Strings.enterName,
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 3, color: AppTheme.darkYellow)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 3, color: AppTheme.darkYellow)),
      ));
}
