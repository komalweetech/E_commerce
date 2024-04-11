
import 'package:buzz/screen/shopping/AllOrder_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../main.dart';
import '../utils/Colors.dart';
import '../utils/Widgets.dart';

class ProfileFragment extends StatefulWidget {
  const ProfileFragment({super.key,required this.title});
  final String title;

  @override
  State<ProfileFragment> createState() => _ProfileFragmentState();
}

class _ProfileFragmentState extends State<ProfileFragment> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: const Image(image: AssetImage('assets/images/ic_arrivals_1.jpg'), height: 100, width: 100, fit: BoxFit.cover),
                  ),
                ),
                Align(
                  alignment: const Alignment(0.2, -0.2),
                  child: Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    width: 50,
                    height: 30,
                    decoration: BoxDecoration(color: const Color(0xff000000), shape: BoxShape.circle, border: Border.all(color: const Color(0x4d9e9e9e), width: 1)),
                    child: const Icon(Icons.edit, color: Color(0xffffffff), size: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20, width: 16),
            Text("User Name", style: primaryTextStyle()),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                settingWidget(title: '0', subtitle: 'Processing'),
                Container(height: 30, width: 1, color: Colors.grey, margin: const EdgeInsets.only(bottom: 16)),
                settingWidget(title: '1', subtitle: 'Shipped'),
                Container(
                  height: 30,
                  width: 1,
                  color: Colors.grey,
                  margin: const EdgeInsets.only(bottom: 16),
                ),
                settingWidget(title: '0', subtitle: 'Pickup'),
              ],
            ),
            const SizedBox(height: 30),
            Padding(
              padding:  EdgeInsets.all(12),
              child: GestureDetector(
                onTap: () {
                  Get.to(const AllOrderScreen());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("My order", textAlign: TextAlign.start, overflow: TextOverflow.clip, style: boldTextStyle(size: 16)),
                    Icon(Icons.arrow_forward_ios, color: Colors.black, size: 19),
                  ],
                ),
              ),
            ),
            Divider(color: Colors.grey.withOpacity(0.5), height: 16, thickness: 0, indent: 0, endIndent: 0),
            Padding(
              padding:  EdgeInsets.all(12),
              child: GestureDetector(
                onTap: () {
                  // Get.to(UpDateProfile());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("UpDate Profile", textAlign: TextAlign.start, overflow: TextOverflow.clip, style: boldTextStyle(size: 16)),
                    const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 19),
                  ],
                ),
              ),
            ),
            Divider(color: Colors.grey.withOpacity(0.5), height: 16, thickness: 0, indent: 0, endIndent: 0),

            Padding(
              padding:  EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('DarkMode', style: boldTextStyle(size: 16)),
                  Transform.scale(
                    scale: 1,
                    child: Switch(
                      value: appStore.isDarkModeOn,
                      activeColor: appColorPrimary,
                      onChanged: (s) {
                        appStore.toggleDarkMode(value: s);
                      },
                    ),
                  )
                ],
              ).onTap(() {
                appStore.toggleDarkMode();
              }),
            ),
            Divider(color: Colors.grey.withOpacity(0.5), height: 16, thickness: 0, indent: 0, endIndent: 0),
          ],
        ),
      ),
    );
  }
}
