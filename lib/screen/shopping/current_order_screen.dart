// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_print
import 'package:buzz/controller/cart_Price_controller.dart';
import 'package:buzz/utils/app_constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/order_model.dart';


class CurrentOrdersScreen extends StatefulWidget {
  const CurrentOrdersScreen({super.key});

  @override
  State<CurrentOrdersScreen> createState() => _CurrentOrdersScreenState();
}

class _CurrentOrdersScreenState extends State<CurrentOrdersScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  final CartPriceController cartPriceController = Get.put(CartPriceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme:IconThemeData(
          color: AppConstant.appTextColor
        ) ,
        backgroundColor: AppConstant.appPrimaryColor,
        title: Text('Current Orders',style: TextStyle(color: AppConstant.appTextColor),),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('customerId', isEqualTo: user!.uid)
            .where('status', isEqualTo: false) // Assuming 'orderStatus' field indicates whether an order is current or not
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: Get.height / 5,
              child: Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No products found!"),
            );
          }

            if(snapshot.data != null) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final productData = snapshot.data!.docs[index];
                  OrderModel orderModel = OrderModel(
                    productId: productData['productId'],
                    productName: productData['productName'],
                    fullPrice: productData['fullPrice'],
                    productImages: List<String>.from(productData['productImages']),
                    deliveryTime: productData['deliveryTime'],
                    productDescription: productData['productDescription'],
                    createdAt: (productData['createdAt'] as Timestamp).toDate(),
                    updatedAt:( productData['updatedAt'] as Timestamp).toDate(),
                    productQuantity: productData['productQuantity'],
                    productTotalPrice: double.parse(
                        productData['productTotalPrice'].toString()),
                    customerId: productData['customerId'],
                    orderStatus: productData['status'],
                    customerName: productData['customerName'],
                    customerPhone: productData['customerPhone'],
                    customerAddress: productData['customerAddress'],
                    customerDeviceToken: productData['customerDeviceToken'],
                  );

                  //calculate price
                  cartPriceController.fetchProductPrice();
                  return Padding(
                    padding:  EdgeInsets.only(left: 15.0,right: 15.0,top: 15.0,),
                    child: Card(
                      elevation: 5,
                      color: AppConstant.appTextColor,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppConstant.appPrimaryColor,
                          backgroundImage:
                          NetworkImage(orderModel.productImages.first),
                        ),
                        title: Text(orderModel.productName),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(orderModel.productTotalPrice.toString()),
                            SizedBox(
                              width: 10.0,
                            ),
                      Text("Pending..", style: TextStyle(color:AppConstant.appPrimaryColor),  )
                            // orderModel.orderStatus != true
                            //     ? Text(
                            //   "Pending..",
                            //   style: TextStyle(color:AppConstant.appPrimaryColor),
                            // )
                            //     : Text(
                            //   "Deliverd",
                            //   style: TextStyle(color: AppConstant.appPrimaryColor),
                            // )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }


          return Container();
        },
      ),
    );
  }
}