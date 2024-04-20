import 'package:buzz/model/favoriteItem_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:buzz/component/BestODWidget.dart';
import 'package:buzz/screen/details/DetailScreen.dart';
import 'package:buzz/screen/ViewAllScreen.dart';
import 'package:buzz/utils/DataGenerator.dart';
import 'package:buzz/utils/Widgets.dart';
import '../model/ShoppingModel.dart';
import '../model/product_model.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({super.key,required this.title});
  final String title;

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  final List<ShoppingModel> data = getSearchData();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('items').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            print('home screen all data == ${ snapshot.hasData}');
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Responsive(
                    web: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: Image(
                          image: const AssetImage('assets/images/ic_banner1.jpg'),
                          height: 600,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover),
                    ),
                    mobile: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                      child: Image(
                        image: const AssetImage('assets/images/ic_banner1.jpg'),
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 8),
                    child: Text("New Arrivals",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: boldTextStyle()),
                  ),
                  HorizontalList(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    itemCount: data.length,
                    itemBuilder: (_, index) {
                      return arrivalWidget(
                          context: context, img: data[index].img);
                    },
                  ),
                  const SizedBox(height: 16, width: 16),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text("Best of Orders",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: boldTextStyle()),
                        TextButton(
                          onPressed: () {
                            Get.to(const AllProductsScreen());
                          },
                          child: Text("Show all", style: secondaryTextStyle()),
                        ),
                      ],
                    ),
                  ),
                  Responsive(
                    mobile: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final productData = snapshot.data!.docs[index];
                        ProductModel productModel = ProductModel(
                          productId: productData['productId'],
                          productName: productData['productName'],
                          fullPrice: productData['fullPrice'],
                          productImages: productData['productImages'],
                          deliveryTime: productData['deliveryTime'],
                          productDescription: productData['productDescription'],
                          createdAt: productData['createdAt'],
                          updatedAt: productData['updatedAt'],
                        );

                        print('Home screen Product Id == ${productModel.productId}');

                        // CategoriesModel categoriesModel = CategoriesModel(
                        //   categoryId: snapshot.data!.docs[index]['categoryId'],
                        //   categoryImg: snapshot.data!.docs[index]['categoryImg'],
                        //   categoryName: snapshot.data!.docs[index]['categoryName'],
                        //   createdAt: snapshot.data!.docs[index]['createdAt'],
                        //   updatedAt: snapshot.data!.docs[index]['updatedAt'],
                        // );
                        return Container(
                          height: Get.height / 3,
                          child: InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              Get.to(DetailScreen(productModel: productModel,));
                            },
                            child: BestODWidget(
                              image: productModel.productImages.first,
                              name: productModel.productName,
                              subName: productModel.deliveryTime,
                              amount: productModel.fullPrice,
                              favoriteItem: FavoriteItemModel(
                                  productId: productModel.productId,
                                  productName: productModel.productName,
                                  fullPrice: productModel.fullPrice,
                                  productImages: productModel.productImages,
                                  deliveryTime: productModel.deliveryTime,
                                  productDescription: productModel.productDescription,
                                  createdAt: productModel.createdAt,
                                  updatedAt: productModel.updatedAt),

                              disc: productModel.productDescription,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                ],
              ),
            );
          }),
    );
  }

  Future<void> dialog() async {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: SizedBox(
            height: 300,
            width: 300,
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image(
                        image:
                            const AssetImage('assets/images/ic_arrivals_2.jpg'),
                        height: 200,
                        width: Get.width,
                        fit: BoxFit.cover),
                    IconButton(
                      onPressed: () {
                        finish(context);
                      },
                      icon: const Icon(Icons.close, color: Colors.black),
                    )
                  ],
                ),
                Container(
                  height: 80,
                  padding: const EdgeInsets.all(16),
                  width: Get.width,
                  color: context.cardColor,
                  child: sSAppButton(
                    textColor: Colors.white,
                    title: 'Shop Now',
                    context: context,
                    onPressed: () {
                      finish(context);
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
