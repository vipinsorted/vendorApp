// import 'package:circle_list/circle_list.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
//
// import '../network/shared_prefs.dart';
// import '../styles.dart';
// import '../themes.dart';
//
// class BuildCartItemsWidget extends StatefulWidget {
//   final getController;
//   final ScrollController scrollController;
//   const BuildCartItemsWidget(
//       {Key? key, required this.getController, required this.scrollController})
//       : super(key: key);
//
//   @override
//   State<BuildCartItemsWidget> createState() => _BuildCartItemsWidgetState();
// }
//
// class _BuildCartItemsWidgetState extends State<BuildCartItemsWidget> {
//   @override
//   RxString baseUrl = "".obs;
//   FocusNode focusNode = FocusNode();
//   bool isFocused = false;
//
//   init() async {
//     baseUrl.value = (await SharedPref.getBaseUrl())!;
//     setState(() {});
//   }
//
//   @override
//   void initState() {
//     init();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(top: Insets.lg, bottom: Insets.med),
//       child: widget.getController.itemCount! > 8
//           ? buildGridView()
//           : widget.getController.itemCount! > 5
//               ? CircleList(
//                   innerRadius: Insets.offset / 2,
//                   outerRadius: widget.getController.orderItems!.length < 2
//                       ? Insets.offset / 2
//                       : Insets.offsetMed * 1.4,
//                   origin: const Offset(0, 0),
//                   childrenPadding: Insets.lg,
//                   centerWidget: Column(
//                     children: [
//                       SizedBox(height: Insets.xs * 0.8),
//                       CircleAvatar(
//                           radius: Corners.outerAvatarRadius - 1.5,
//                           backgroundColor: AppTheme.buttonColor,
//                           child: CircleAvatar(
//                             backgroundImage: NetworkImage(
//                                 "${baseUrl.value}${widget.getController.orderItems?.first.imageUrl!}"),
//                             backgroundColor: AppTheme.white,
//                           )),
//                       Expanded(
//                           child: Text(
//                         "${widget.getController.orderItems!.first.finalQuantity!.toStringAsFixed(2)}${widget.getController.orderItems?.first.unitOfMeasurement} |₹ ${widget.getController.orderItems?.first.finalAmount!.toStringAsFixed(2)}",
//                         style: TextStyles.body1
//                             .copyWith(fontSize: 9, fontWeight: FontWeight.w600),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ))
//                     ],
//                   ),
//                   children: List.generate(
//                       widget.getController.orderItems!.length - 1, (index) {
//                     return Column(
//                       children: [
//                         CircleAvatar(
//                             radius: Corners.outerAvatarRadius - 1.5,
//                             backgroundColor: AppTheme.buttonColor,
//                             child: CircleAvatar(
//                               backgroundImage: NetworkImage(
//                                   "${baseUrl.value}${widget.getController.orderItems![index + 1].imageUrl!}"),
//                               backgroundColor: AppTheme.white,
//                             )),
//                         Expanded(
//                             child: Text(
//                           "${widget.getController.orderItems?[index + 1].finalQuantity!.toStringAsFixed(2)}${widget.getController.orderItems?[index + 1].unitOfMeasurement} |₹ ${widget.getController.orderItems![index + 1].finalAmount!.toStringAsFixed(2)}",
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyles.body1.copyWith(
//                               fontSize: 9, fontWeight: FontWeight.w600),
//                         ))
//                       ],
//                     );
//                   }),
//                 )
//               : buildGridView2(),
//     );
//   }
//
//   Widget categoryItem2({required String label, required int index}) =>
//       GestureDetector(
//           behavior: HitTestBehavior.translucent,
//           child: Obx(() => Column(
//                 children: [
//                   CircleAvatar(
//                       radius: Corners.outerAvatarRadius - 1.5,
//                       backgroundColor: AppTheme.buttonColor,
//                       child: CircleAvatar(
//                         backgroundImage: NetworkImage(
//                             "${baseUrl.value}${widget.getController.orderItems?[index].imageUrl!}"),
//                         backgroundColor: AppTheme.white,
//                       )),
//                   Text(
//                     "${widget.getController.orderItems?[index].finalQuantity!.toStringAsFixed(2)}${widget.getController.orderItems?[index].unitOfMeasurement} |₹ ${widget.getController.orderItems![index].finalAmount!.toStringAsFixed(2)}",
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyles.title1.copyWith(fontSize: 10),
//                   )
//                 ],
//               )),
//           onTap: () {});
//   Widget buildGridView() {
//     return Padding(
//         padding: EdgeInsets.only(left: Insets.xl, right: Insets.xl),
//         child: GridView.builder(
//           physics: const ScrollPhysics(),
//           controller: widget.scrollController,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisSpacing: Insets.sm,
//             crossAxisCount: 3,
//             childAspectRatio: 1.1,
//           ),
//           itemCount: widget.getController.orderItems!.length,
//           shrinkWrap: true,
//           itemBuilder: (_, index) => categoryItem2(
//               label: widget.getController.orderItems?[index].productName!,
//               index: index),
//         ));
//   }
//
//   Widget buildGridView2() {
//     return widget.getController.orderItems?.length == 1
//         ? Padding(
//             padding: EdgeInsets.only(top: Insets.xl, bottom: Insets.xl),
//             child: Center(
//                 child: categoryItem2(
//                     label: widget.getController.orderItems?.first.productName,
//                     index: 0)))
//         : Padding(
//             padding: EdgeInsets.only(left: Insets.xl, right: Insets.xl),
//             child: GridView.builder(
//               physics: const ScrollPhysics(),
//               controller: widget.scrollController,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisSpacing: Insets.sm,
//                 crossAxisCount: 2,
//                 childAspectRatio: 1.6,
//               ),
//               itemCount: widget.getController.orderItems?.length,
//               shrinkWrap: true,
//               itemBuilder: (_, index) => categoryItem2(
//                   label: widget.getController.orderItems?[index].productName!,
//                   index: index),
//             ));
//   }
// }
