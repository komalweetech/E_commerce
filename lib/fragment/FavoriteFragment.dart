
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../model/product_model.dart';
import '../screen/details/DetailScreen.dart';
import '../screen/widgets/card_widget.dart';


class FavoriteFragment extends StatefulWidget {
  final String userId;

  const FavoriteFragment({Key? key,required this.userId}) : super(key: key);

  @override
  _FavoriteFragmentState createState() => _FavoriteFragmentState();
}

class _FavoriteFragmentState extends State<FavoriteFragment> {


  @override
  Widget build(BuildContext context) {
    print('Building FavoriteFragment widget');
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('favorite')
            .doc(widget.userId) // Reference the user's document
            .collection('items')
            .snapshots(),

        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print('Firestorm stream: Waiting for data...');
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            print('Firestorm stream error: ${snapshot.error}');
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No favorite items found'));
          }
          print('Firestorm stream: Data received...');
          return ListView.separated(
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
                size: productData['size'],
                createdAt: productData['createdAt'],
                updatedAt: productData['updatedAt'],
              );
              print('Favorite screen Product Id == ${productModel.productId}');
              return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(7),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(7),
                        onTap: () {
                          Get.to(DetailScreen(
                            productModel: productModel,
                          ));
                        },
                        onLongPress: () {},
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: SizedBox(
                                height: Get.height / 3,
                                width: Get.width,
                                child: Image.network(
                                  productModel.productImages.first, fit: BoxFit.cover,),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              right: 10,
                              child: CardWidget(
                                name: productModel.productName,
                                subName: productModel.createdAt,
                                amount: productModel.fullPrice,),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
              );
            },
            separatorBuilder: (context, index) {
              print('Building separator $index');
              return const Divider(
                color: Colors.grey,
                thickness: 1,
                height: 1,
              );
            },
          );
        },
      ),
    );
  }
}