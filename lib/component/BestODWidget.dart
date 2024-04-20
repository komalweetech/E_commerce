

import 'package:buzz/model/favoriteItem_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nb_utils/nb_utils.dart';

class BestODWidget extends StatefulWidget {
  final String? image;
  final String? name;
  final String? subName;
  final String? amount;
  final String? disc;
  final FavoriteItemModel favoriteItem;
  final Function(bool)? onFavoriteToggle;
  final VoidCallback? onFavoriteChanged;

  const BestODWidget({
    super.key,
    this.image,
    this.name,
    this.subName,
    this.amount,
    this.disc,
    required this.favoriteItem,
    this.onFavoriteToggle,
    this.onFavoriteChanged,
  });

  @override
  State<BestODWidget> createState() => _BestODWidgetState();
}

class _BestODWidgetState extends State<BestODWidget>  {
  late bool isFavorite = false;

  Future<void> handleFavoriteToggle(bool isFavorite) async {
    widget.onFavoriteToggle?.call(isFavorite);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Add or remove the item from the "favorite" collection based on its favorite status
    if (isFavorite) {
      await FirebaseFirestore.instance
          .collection('favorite')
          .add(widget.favoriteItem.toMap());

      // save data to local database
      List<String> favoriteItems = prefs.getStringList('favorite_items') ?? [];
      favoriteItems.add(widget.favoriteItem.productName);
      await prefs.setStringList('favorite_items', favoriteItems);
    } else {
      // Retrieve the document ID of the item in the "favorite" collection
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('favorite')
          .where('productId', isEqualTo: widget.favoriteItem.productId)
      // .limit(1)
          .get();

      print("constracture  product id = ${widget.favoriteItem.productId}");
      print("snapshot product id = ${querySnapshot.docs}");

      // Delete the document from the "favorite" collection
      if (querySnapshot.docs.isNotEmpty) {
        try {
          await FirebaseFirestore.instance
              .collection('favorite')
              .doc(querySnapshot.docs.first.id)
              .delete();

          // Update local storage
          List<String> favoriteItems = prefs.getStringList('favorite_items') ??
              [];
          favoriteItems.remove(widget.favoriteItem.productName);
          await prefs.setStringList('favorite_items', favoriteItems);
        } catch (e){
          print('Error deleting document: $e');
        }
      }
    }
  }
//C:\Users\WS 01\AppData\Local\Android\Sdk

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: 12,left: 12,right: 12),
      child: SizedBox(
        width: Get.width / 2 - 24,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(08),
              height: 200,
              child: Column(
                children: [
                  const SizedBox(height: 1),
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () async {
                        print('Favorite icon tapped for ${widget.name}');

                        setState(() {
                          isFavorite = !isFavorite;
                        });

                        await handleFavoriteToggle(isFavorite);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        child: Icon(
                          Icons.favorite,
                          color: isFavorite ? Colors.red : Colors.black26,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(height: 16),
                  Expanded(
                      child: Image.network(widget.image!,
                          height: Get.height /1.5,
                          width: Get.width,
                          fit: BoxFit.cover)),
                ],
              ),
            ),
            // const SizedBox(height: 4),
            Padding(
              padding:  EdgeInsets.only(left: 15.0,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name!, style: boldTextStyle(size: 14)),
                  // const SizedBox(height: 4),
                  SizedBox(
                    width:Get.width/ 2 - 12,
                    child: Text(widget.subName!, maxLines: 2, style: secondaryTextStyle(size: 12)),
                  ),
                  // const SizedBox(height: 4),
                  Text("\$ ${widget.amount!}", style: secondaryTextStyle(size: 12)),
                ],  //C:\Users\WS 01\AppData\Local\Android\Sdk
              ),
            )

          ],
        ),
      ),
    );
  }

}
