// ignore_for_file: file_names, avoid_print, unused_local_variable, prefer_const_constructors

import 'package:buzz/screen/shopping/PaymentScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/order_model.dart';
import '../../utils/app_constant.dart';
import 'genrate_order_id_service.dart';

void placeOrder({
  required BuildContext context,
  required String customerName,
  required String customerPhone,
  required String customerAddress,
  required String customerDeviceToken,
}) async {
  final user = FirebaseAuth.instance.currentUser;
  // EasyLoading.show(status: "Please Wait..");
  if (user != null) {
    if (customerPhone.length != 10 || int.tryParse(customerPhone) == null) {
      print("Invalid phone number format");
      return;
    }
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('cart')
          .doc(user.uid)
          .collection('cartOrders')
          .get();

      List<QueryDocumentSnapshot> documents = querySnapshot.docs;

      List<OrderModel> orders = [];
      for (var doc in documents) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>;

        String orderId = generateOrderId();

        OrderModel orderModel = OrderModel(
          productId: data['productId'],
          productName: data['productName'],
          fullPrice: data['fullPrice'],
          productImages: data['productImages'],
          deliveryTime: data['deliveryTime'],
          productDescription: data['productDescription'],
          createdAt: DateTime.now(),
          updatedAt: data['updatedAt'],
          productQuantity: data['productQuantity'],
          productTotalPrice: double.parse(data['productTotalPrice'].toString()),
          customerId: user.uid,
          orderStatus: false,
          customerName: customerName,
          customerPhone: customerPhone,
          customerAddress: customerAddress,
          customerDeviceToken: customerDeviceToken,
        );
        print("Place order screen product id = ${orderModel.productId}");
        orders.add(orderModel); // Add the orderModel to the list
        for (var x = 0; x < documents.length; x++) {
          // await FirebaseFirestore.instance
          //     .collection('orders')
          //     .doc(user.uid)
          //     .set(
          //   {
          //     'uId': user.uid,
          //     'customerName': customerName,
          //     'customerPhone': customerPhone,
          //     'customerAddress': customerAddress,
          //     'customerDeviceToken': customerDeviceToken,
          //     'orderStatus': false,
          //     'createdAt': DateTime.now()
          //   },
          // );

          //upload orders
          await FirebaseFirestore.instance
              .collection('orders')
              // .doc(user.uid)
              // .collection('confirmOrders')
              .doc(orderId)
              .set(orderModel.toMap());

          // delete cart products
          await FirebaseFirestore.instance
              .collection('cart')
              .doc(user.uid)
              .collection('cartOrders')
              .doc(orderModel.productId.toString())
              .delete()
              .then((value) {
            print('Delete cart Products ${orderModel.productId.toString()}');
          });
        }
      }

      // count total order price.
      double calculateTotalPrice(List<OrderModel> orders) {
        double totalPrice = 0;
        for (var order in orders) {
          totalPrice += order.productTotalPrice;
        }
        return totalPrice;
      }

      print("Order Confirmed");
      Get.snackbar(
        "Order Confirmed",
        "Thank you for your order!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.appPrimaryColor,
        colorText: Colors.white,
        duration: Duration(seconds: 5),
      );

      // EasyLoading.dismiss();
      // Get.offAll(() => DashBoardScreen());
      Get.to(PaymentScreen(totalPrice: calculateTotalPrice(orders), orders: orders,));
    } catch (e) {
      print("error $e");
    }
  }
}
