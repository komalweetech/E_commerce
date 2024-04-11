import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:buzz/main.dart';
import 'package:buzz/screen/shopping/OrderScreen.dart';
import 'package:buzz/utils/DataGenerator.dart';
import 'package:buzz/utils/Widgets.dart';

import '../../model/ShoppingModel.dart';
import '../../model/order_model.dart';
import '../../utils/app_constant.dart';


class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key,required this.totalPrice,required this.orders});
  final List<OrderModel> orders;
  final double totalPrice;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}


class _PaymentScreenState extends State<PaymentScreen> {
  int mCount = 0;
  double shippingFee = 24;

  List<ShoppingModel> payment = paymentList();

  @override
  Widget build(BuildContext context) {
    double subTotal = widget.totalPrice;
    double totalPayment = subTotal + shippingFee;

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Icon(Icons.location_on, color: Color(0xff808080), size: 24),
                Container(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: appStore.isDarkModeOn ? context.iconColor : const Color(0xff000000),
                    shape: BoxShape.circle,
                    border: Border.all(color: appStore.isDarkModeOn ? context.iconColor : const Color(0xff000000), width: 1),
                  ),
                ),
                Container(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: appStore.isDarkModeOn ? context.iconColor : const Color(0xff000000),
                    shape: BoxShape.circle,
                    border: Border.all(color: appStore.isDarkModeOn ? context.iconColor : const Color(0xff000000), width: 1),
                  ),
                ),
                Container(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: appStore.isDarkModeOn ? context.iconColor : const Color(0xff000000),
                    shape: BoxShape.circle,
                    border: Border.all(color: appStore.isDarkModeOn ? context.iconColor : const Color(0xff000000), width: 1),
                  ),
                ),
                Container(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: appStore.isDarkModeOn ? context.iconColor : const Color(0xff000000),
                    shape: BoxShape.circle,
                    border: Border.all(color: appStore.isDarkModeOn ? context.iconColor : const Color(0xff000000), width: 1),
                  ),
                ),
                const Icon(Icons.credit_card, color: Color(0xff808080), size: 24),
                Container(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0x1f000000),
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
                  ),
                ),
                Container(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0x1f000000),
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
                  ),
                ),
                Container(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0x1f000000),
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
                  ),
                ),
                Container(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0x1f000000),
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
                  ),
                ),
                const Icon(Icons.verified, color: Color(0xff808080), size: 24),
              ],
            ),
            const SizedBox(height: 32, width: 16),
            Text("Payment Option", textAlign: TextAlign.start, overflow: TextOverflow.clip, style: boldTextStyle()),
            const SizedBox(height: 16, width: 16),
            ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              shrinkWrap: true,
              itemCount: payment.length,
              itemBuilder: (_, index) {
                return InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    mCount = index;
                    setState(() {});
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 8, bottom: 8),
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: mCount == index ? context.iconColor : Colors.grey.withOpacity(0.3), width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.zero,
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: mCount == index ? context.iconColor : Colors.grey.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                          ),
                          Text(
                            payment[index].name!,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: boldTextStyle(color: mCount == index ? context.iconColor : Colors.grey.withOpacity(0.5)),
                          ),
                          Image(image: AssetImage(payment[index].img!), height: 30, width: 30, fit: BoxFit.cover),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 16),
        height: 220,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: context.cardColor,
          boxShadow: defaultBoxShadow(),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('Sub - total', style: secondaryTextStyle()),
                ),
                Text('\$$subTotal', style: boldTextStyle()),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(color: Colors.grey, height: 1),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Shipping fee', style: secondaryTextStyle()),
                Text('\$$shippingFee', style: boldTextStyle()),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Payment', style: primaryTextStyle()),
                Text('\$$totalPayment', style: boldTextStyle()),
              ],
            ),
            const SizedBox(height: 25),
            sSAppButton(
              context: context,
              title: 'Place Order',
              onPressed: () async {
                const OrderScreen().launch(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
