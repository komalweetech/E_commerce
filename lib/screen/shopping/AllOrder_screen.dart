import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/cart_Price_controller.dart';
import '../../model/order_model.dart';
import '../../utils/app_constant.dart';

class AllOrderScreen extends StatefulWidget {
  const AllOrderScreen({super.key});

  @override
  State<AllOrderScreen> createState() => _AllOrderScreenState();
}

class _AllOrderScreenState extends State<AllOrderScreen> {
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
        title: Text('All Orders',style: TextStyle(color: AppConstant.appTextColor),),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: Get.height / 5,
              child: const Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return const Center(
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
                  productImage: productData['productImage'],
                  size: productData['size'],
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
                        NetworkImage(orderModel.productImage),
                      ),
                      title: Text(orderModel.productName),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(orderModel.productTotalPrice.toString()),
                          const SizedBox(
                            width: 10.0,
                          ),
                          orderModel.orderStatus != true
                              ? Text(
                            "Pending..",
                            style: TextStyle(color:AppConstant.appPrimaryColor),
                          )
                              : Text(
                            "Deliverd",
                            style: TextStyle(color: AppConstant.appPrimaryColor),
                          )
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
