// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:buzz/component/BestODWidget.dart';
// import 'package:buzz/screen/details/DetailScreen.dart';
// import 'package:buzz/utils/DataGenerator.dart';
//
// import '../model/ShoppingModel.dart';
//
// class ProductItemWidget extends StatelessWidget {
//   final List<ShoppingModel> list = getAllData();
//
//   ProductItemWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.fromLTRB(16, 16, 16, 60),
//       child: Wrap(
//         runSpacing: 16,
//         spacing: 16,
//         children: list.asMap().entries.map(
//               (entry) {
//             final index = entry.key;
//             final item = entry.value;
//             return InkWell(
//               highlightColor: Colors.transparent,
//               splashColor: Colors.transparent,
//               onTap: () {
//                 Get.to( DetailScreen(productId: "",image: "", name: '', subName: '', amount: '', desc: '',));
//                 },
//               child: BestODWidget(
//                 name: item.name,
//                 image: item.img,
//                 subName: item.subtitle,
//                 amount: item.amount,
//               ),
//             );
//           },
//         ).toList(),
//       ),
//     );
//   }
// }
