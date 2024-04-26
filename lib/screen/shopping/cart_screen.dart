// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, avoid_print
import 'package:buzz/controller/cart_Price_controller.dart';
import 'package:buzz/screen/shopping/checkOut_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';

import '../../model/cart_model.dart';
import '../../utils/app_constant.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, required this.title});

  final String title;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("current user = ${user!.uid}");
  }
  final CartPriceController cartPriceController = Get.put(CartPriceController());
  List<CartModel> cartItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('cart')
            .doc(user!.uid)
            .collection('cartOrders')
            .get(),
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
          if (snapshot.data != null) {
            return Container(
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final productData = snapshot.data!.docs[index];
                  CartModel cartModel = CartModel(
                    productId: productData['productId'],
                    productName: productData['productName'],
                    fullPrice: productData['fullPrice'],
                    productImage: productData['productImage'],
                    deliveryTime: productData['deliveryTime'],
                    productDescription: productData['productDescription'],
                    createdAt: productData['createdAt'],
                    updatedAt: productData['updatedAt'],
                    productQuantity: productData['productQuantity'],
                    productTotalPrice: productData['productTotalPrice'],
                    size: productData['size'],
                  );

                  //calculate price
                  cartPriceController.fetchProductPrice();
                  return SwipeActionCell(
                    key: ObjectKey(cartModel.productId),
                    trailingActions: [
                      SwipeAction(
                        title: "Delete",
                        forceAlignmentToBoundary: true,
                        performsFirstActionWithFullSwipe: true,
                        onTap: (CompletionHandler handler) async {
                          print('deleted');

                          await FirebaseFirestore.instance
                              .collection('cart')
                              .doc(user!.uid)
                              .collection('cartOrders')
                              .doc(cartModel.productId)
                              .delete();
                        },
                      )
                    ],
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
                      child: SizedBox(
                        height: Get.height / 6.5,
                        width: Get.width / 2,
                        child: Card(
                          margin: EdgeInsets.all(10.0),
                          elevation: 5,
                          color: AppConstant.appTextColor,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: ListTile(
                              leading: Container(
                                width: 50.0,
                                // Adjust the width and height as needed
                                height: 50.0,
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:
                                      NetworkImage(cartModel.productImage),
                                  radius: 50.0,
                                ),
                              ),
                              title: Text(
                                cartModel.productName,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              subtitle: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("\$ ${cartModel.productTotalPrice.toString()}"),
                                  SizedBox(
                                    width: Get.width / 20.0,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if (cartModel.productQuantity > 1) {
                                        await FirebaseFirestore.instance
                                            .collection('cart')
                                            .doc(user!.uid)
                                            .collection('cartOrders')
                                            .doc(cartModel.productId)
                                            .update({
                                          'productQuantity': cartModel.productQuantity - 1,
                                          'productTotalPrice': (double.parse(
                                                  cartModel.fullPrice) *
                                              (cartModel.productQuantity - 1))
                                        });
                                        // Retrieve updated quantity from Firestore
                                        var updatedData =
                                            await FirebaseFirestore.instance
                                                .collection('cart')
                                                .doc(user!.uid)
                                                .collection('cartOrders')
                                                .doc(cartModel.productId)
                                                .get();
                                        // Update the quantity in the cartModel
                                        setState(() {
                                          cartModel = CartModel.fromMap(updatedData.data()!);
                                        });
                                      }
                                    },
                                    child: CircleAvatar(
                                      radius: 14.0,
                                      backgroundColor:
                                          AppConstant.appPrimaryColor,
                                      child: Text('-'),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width / 30.0,
                                  ),
                                  Text(
                                    '${cartModel.productQuantity}',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    width: Get.width / 30.0,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if (cartModel.productQuantity > 0) {
                                        await FirebaseFirestore.instance
                                            .collection('cart')
                                            .doc(user!.uid)
                                            .collection('cartOrders')
                                            .doc(cartModel.productId)
                                            .update({
                                          'productQuantity': cartModel.productQuantity + 1,
                                          'productTotalPrice': double.parse(
                                                  cartModel.fullPrice) + double.parse(cartModel.fullPrice) *
                                                  (cartModel.productQuantity)
                                        });
                                 // Retrieve updated quantity from Firestore
                                        var updatedData =
                                            await FirebaseFirestore.instance
                                                .collection('cart')
                                                .doc(user!.uid)
                                                .collection('cartOrders')
                                                .doc(cartModel.productId)
                                                .get();

                                        // Update the quantity in the cartModel
                                        setState(() {
                                          cartModel = CartModel.fromMap(
                                              updatedData.data()!);
                                        });
                                      }
                                    },
                                    child: CircleAvatar(
                                      radius: 14.0,
                                      backgroundColor:
                                          AppConstant.appPrimaryColor,
                                      child: Text('+'),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return Container();
        },
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 5.0),
        child: Padding(
          padding: EdgeInsets.only(
            left: 20.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Text(
                  " Total: \$ ${cartPriceController.totalPrice.value.toStringAsFixed(1)}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Material(
                  child: Container(
                    width: Get.width / 2.0,
                    height: Get.height / 18,
                    decoration: BoxDecoration(
                      color: AppConstant.appSecondPrimaryColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: TextButton(
                      child: Text(
                        "Checkout",
                        style: TextStyle(color: AppConstant.appTextColor),
                      ),
                      onPressed: () {
                        Get.to(() => CheckOutScreen());
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
