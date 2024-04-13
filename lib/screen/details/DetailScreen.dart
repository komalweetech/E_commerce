import 'package:buzz/model/cart_model.dart';
import 'package:buzz/model/product_model.dart';
import 'package:buzz/screen/shopping/cart_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:buzz/utils/Widgets.dart';
import '../../controller/cart_Price_controller.dart';
import '../../utils/app_constant.dart';

class DetailScreen extends StatefulWidget {
  ProductModel productModel;

  DetailScreen({
    super.key,required this.productModel,
  });

  @override
  DetailScreenState createState() => DetailScreenState();
}

class DetailScreenState extends State<DetailScreen> {
  final CartPriceController cartPriceController = Get.put(CartPriceController()); // Get the cart controller instance
  int selectedIndex = 0; // Define selectedIndex here
  User? user = FirebaseAuth.instance.currentUser;


  @override
  void initState() {
    super.initState();

    print("list of all images == ${widget.productModel.productImages} ");
  }



  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppConstant.appSecondPrimaryColor,
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: AppConstant.appPrimaryColor,
        title: const Text(
          "Product Details",
          style: TextStyle(color: AppConstant.appTextColor),
        ),
        leading: InkWell(
          onTap: () {
            finish(context);
          },
          child: Icon(Icons.arrow_back_ios, size: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.3)),
              child: Column(
                children: [
                  Image(
                    image: NetworkImage(widget.productModel.productImages[selectedIndex]),
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: widget.productModel.productImages.map((image) {
                      return InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        radius: 8,
                        onTap: () {
                          setState(() {
                            selectedIndex = widget.productModel.productImages.indexOf(image);
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: context.cardColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: widget.productModel.productImages.indexOf(image) == selectedIndex
                                  ? Colors.red
                                  : Colors.transparent,
                            ),
                          ),
                          child: Image(
                              image: NetworkImage(image),
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover),
                        ),
                      ).paddingRight(8);
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, bottom: 16, top: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.productModel.productName,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: secondaryTextStyle()),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(widget.productModel.createdAt,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: boldTextStyle()),
                      Text("Price: ${widget.productModel.fullPrice}",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: boldTextStyle()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text("Available Sizes",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: boldTextStyle(size: 14)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin:
                            const EdgeInsets.only(right: 8, top: 4, bottom: 4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: const Color(0x4d9e9e9e), width: 1),
                        ),
                        child: Text("US 7",
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.clip,
                            style: boldTextStyle(size: 12)),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: const Color(0x4d9e9e9e), width: 1),
                        ),
                        child: Text("US 8",
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.clip,
                            style: boldTextStyle(size: 12)),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                              color: const Color(0x4d9e9e9e), width: 1),
                        ),
                        child: Text("US 9",
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.clip,
                            style: boldTextStyle(size: 12)),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                              color: const Color(0x4d9e9e9e), width: 1),
                        ),
                        child: Text("US 10",
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.clip,
                            style: boldTextStyle(size: 12)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16, width: 16),
                  Text("Description",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: boldTextStyle()),
                  const SizedBox(height: 8),
                  Text(widget.productModel.productDescription,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: secondaryTextStyle()),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            InkWell(
              onTap: () async {
                await checkProductExistence(uId: user!.uid);
                Get.to(CartScreen(title: "Cart"));
              }, //  call cart function.
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.all(8),
                child: const Icon(Icons.shopping_cart_outlined),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: sSAppButton(
                context: context,
                title: 'Buy Now',
                onPressed: () async {
                  await checkProductExistence(uId: user!.uid);
                  Get.to(CartScreen(title: "Cart"));
                  },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // add product in cart
  Future<void> checkProductExistence({required String uId, int quantityIncrement = 1,}) async {
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection('cart')
        .doc(uId)
        .collection('cartOrders')
        .doc(widget.productModel.productId.toString());

    print('Details screen = ${widget.productModel.productId.toString()}');
    DocumentSnapshot snapshot = await documentReference.get();

    if(snapshot.exists) {
      int currentQuantity = snapshot['productQuantity'];
      int updateQuantity = currentQuantity + quantityIncrement;
      double totalPrice = double.parse(widget.productModel.fullPrice) * updateQuantity;

      await documentReference.update({
        'productQuantity' : updateQuantity,
        'productTotalPrice' : totalPrice,
      });

      print('product exists. Quantity updated.');
    }else{
      await FirebaseFirestore.instance.collection('cart').doc(uId).set({
        'uId' : uId,
        'createdAt' : DateTime.now(),
      });

      CartModel cartModel = CartModel(
          productId: widget.productModel.productId,
          productName: widget.productModel.productName,
          fullPrice: widget.productModel.fullPrice,
          productImages: widget.productModel.productImages,
          deliveryTime: widget.productModel.deliveryTime,
          productDescription: widget.productModel.productDescription,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          productQuantity: 1,
          productTotalPrice: double.parse(widget.productModel.fullPrice),
      );

      print("cart model product id = ${cartModel.productId}");
      await documentReference.set(cartModel.toMap());

      print('product add = ${cartModel}');
      log("Your product add to Cart");
      Get.snackbar("add Cart", "Your product add to cart ",
          duration: Duration(seconds: 2),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor:
          AppConstant.appSecondPrimaryColor,
          colorText: AppConstant.appTextColor);
    }
  }
}
