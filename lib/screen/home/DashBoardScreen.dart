import 'package:buzz/screen/shopping/current_order_screen.dart';
import 'package:buzz/screen/shopping/cart_screen.dart';
import 'package:buzz/utils/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:buzz/fragment/FavoriteFragment.dart';
import 'package:buzz/fragment/HomeFragment.dart';
import 'package:buzz/fragment/ProfileFragment.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../model/product_model.dart';
import '../widgets/custom-drawer-widget.dart';


class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int selectedIndex = 0;

  List<ProductModel> favoriteProducts = [];

  late List<Widget> tabs;


  @override
  void initState() {
    super.initState();

    tabs = [
      const HomeFragment(title: "Home",),
      const CartScreen(title: "Cart",),
      FavoriteFragment(),
      const ProfileFragment(title: "Profile",),
    ];
  }


  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppConstant.appTextColor),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppConstant.appSecondPrimaryColor,
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: AppConstant.appPrimaryColor,
        title:  Text(
          "Home",
          style: TextStyle(color: AppConstant.appTextColor),
        ),
        elevation: 0,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () => Get.to(CurrentOrdersScreen()),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ),
        ],
      ),
      drawer: DrawerWidget(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '', activeIcon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: '', activeIcon: Icon(Icons.shopping_cart)),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: '', activeIcon: Icon(Icons.favorite)),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: '', activeIcon: Icon(Icons.person)),
        ],
        currentIndex: selectedIndex,
        backgroundColor: AppConstant.appPrimaryColor,
        unselectedItemColor: AppConstant.appTextColor,
        selectedItemColor: AppConstant.appTextColor,
        iconSize: 30,
        selectedFontSize: 14,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        unselectedFontSize: 14,
        onTap: (index) {
          selectedIndex = index;
          setState(() {});
        },
        type: BottomNavigationBarType.fixed,
      ),
      body: tabs[selectedIndex],
    );
  }
}
