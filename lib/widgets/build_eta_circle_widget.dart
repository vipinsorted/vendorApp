// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
//
// import '../network/shared_prefs.dart';
// import '../styles.dart';
// import '../themes.dart';
//
// class BuildEtaCircleWidget extends StatefulWidget {
//   const BuildEtaCircleWidget({Key? key, required this.getController})
//       : super(key: key);
//   final getController;
//   @override
//   State<BuildEtaCircleWidget> createState() => _BuildEtaCircleWidgetState();
// }
//
// class _BuildEtaCircleWidgetState extends State<BuildEtaCircleWidget> {
//   @override
//   String orderId = '';
//   String baseUrl = "";
//   OrderListController orderListController = Get.put(OrderListController());
//   TrackOrderController trackOrderController = Get.put(TrackOrderController());
//   init() async {
//     baseUrl = await SharedPref.getBaseUrl() ?? '';
//     orderId = await SharedPref.getCurrentOrderId() ?? '';
//
//     await orderListController.getOrderDetails(orderId);
//   }
//
//   @override
//   void initState() {
//     init();
//     setState(() {});
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     trackOrderController.timer?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//         behavior: HitTestBehavior.translucent,
//         onTap: () async {
//           await trackOrderController.getOrderTrack(orderId);
//          await SharedPref.setCurrentOrderId(widget.getController.id!);
//           Get.to(
//               TrackOrderDetailsScreen(initialActiveIndex: 2, expanded: false));
//         },
//         child: Stack(children: [
//           DashedCircle(
//             // padding: EdgeInsets.all(Insets.sm),
//             strokeWidth: 2,
//             color: AppTheme.darkYellow,
//             //  borderType: BorderType.Circle,
//             dashes: 12,
//             child: SizedBox(
//               width: Insets.xxl,
//               height: Insets.xxl,
//             ),
//           ),
//           SizedBox(
//             width: Insets.xxl,
//             height: Insets.xxl,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   widget.getController.metadata != null
//                       ? "${widget.getController.metadata?.eta!.actualEta ?? 0}"
//                       : "0",
//                   style: const TextStyle(
//                       fontFamily: "proxima_nova_soft_regular",
//                       fontSize: 12,
//                       color: AppTheme.black,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ],
//             ),
//           ),
//         ]));
//   }
// }
