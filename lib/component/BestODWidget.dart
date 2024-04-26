import 'package:buzz/model/favoriteItem_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

class _BestODWidgetState extends State<BestODWidget> {
   bool isFavorite = false;
  User? user = FirebaseAuth.instance.currentUser;


  @override
  void initState() {
    super.initState();
    getFavoriteState();
    print("current user id == ${user!.uid}");
  }

   void getFavoriteState() async {
     print('Getting favorite state for ${widget.name}');
     SharedPreferences prefs = await SharedPreferences.getInstance();
     setState(() {
       isFavorite = prefs.getBool('isFavorite_${widget.favoriteItem.productId}') ?? false;
     });
   }


   Future<void> handleFavoriteToggle(bool value) async {
    //save data in locat data
     print('Saving favorite state for ${widget.name}: $value');
     SharedPreferences prefs = await SharedPreferences.getInstance();
     await prefs.setBool('isFavorite_${widget.favoriteItem.productId}', value);
     setState(() {
       isFavorite = value;
     });
     widget.onFavoriteToggle?.call(value);
     widget.onFavoriteChanged?.call();

    //  // save data in firebase.
    // setState(() {
    //   isFavorite = !isFavorite;
    // });
    // widget.onFavoriteToggle?.call(isFavorite);

    // Store the favorite item under the user's ID
    await FirebaseFirestore.instance
        .collection('favorite')
        .doc(user!.uid)
        .collection('items')
        .doc(widget.favoriteItem.productId)
        .set(widget.favoriteItem.toMap());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12, left: 12, right: 12),
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
                        handleFavoriteToggle(!isFavorite);
                        // saveFavoriteState(!isFavorite);
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
                          height: Get.height / 1.5,
                          width: Get.width,
                          fit: BoxFit.cover)),
                ],
              ),
            ),
            // const SizedBox(height: 4),
            Padding(
              padding: EdgeInsets.only(left: 15.0,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name!, style: boldTextStyle(size: 14)),
                  // const SizedBox(height: 4),
                  SizedBox(
                    width: Get.width / 2 - 12,
                    child: Text(widget.subName!, maxLines: 2,
                        style: secondaryTextStyle(size: 12)),
                  ),
                  // const SizedBox(height: 4),
                  Text("\$ ${widget.amount!}",
                      style: secondaryTextStyle(size: 12)),
                ], //C:\Users\WS 01\AppData\Local\Android\Sdk
              ),
            )

          ],
        ),
      ),
    );
  }

}


