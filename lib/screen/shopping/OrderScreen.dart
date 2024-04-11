import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:lottie/lottie.dart';
import 'package:buzz/screen/home/DashBoardScreen.dart';
import 'package:buzz/utils/Widgets.dart';
import '../../utils/app_constant.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

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
          "Checkout",
          style: TextStyle(color: AppConstant.appTextColor,fontWeight: FontWeight.w500),
        ),
        leading: InkWell(
          onTap: () {
            finish(context);
          },
          child: Icon(Icons.arrow_back_ios, color: AppConstant.appTextColor, size: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(AppConstant.appPrimaryColor, BlendMode.srcIn),
                child: Lottie.asset("assets/images/splash.json",),
              ),
            ),
            sSAppButton(
              color: AppConstant.appPrimaryColor,
              context: context,
              title: 'Continue shopping',
              onPressed: () {
                const DashBoardScreen().launch(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
