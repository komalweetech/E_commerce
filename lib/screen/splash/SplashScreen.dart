import 'dart:async';

import 'package:buzz/controller/user_signUp_controller.dart';
import 'package:buzz/screen/home/DashBoardScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:buzz/screen/auth/welcomeScreen.dart';
import 'package:buzz/utils/Widgets.dart';
import '../../controller/get_user_data_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // save user or admin for  this variable.
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3) ,() {
      alreadyLoginUser(context);
      // Get.offAll(WelcomeScreen());
    });
  } // get user name
  String? getUserDisplayName() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print("user display name = ${user.displayName}");
      return user.displayName;
    } else {
      return null;
    }
  }
  // check user already loged in or new?
  Future<void> alreadyLoginUser (BuildContext context) async {
    if(user != null) {
      String? userName = getUserDisplayName();
      Get.offAll(DashBoardScreen());

    }else{
      Get.offAll(const WelComeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(0),
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 50),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.zero,
                    border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Image(
                        image: AssetImage('assets/images/ic_logo.png'),
                        height: 100,
                        width: 100,
                        // color: appStore.isDarkModeOn ? Colors.white : Colors.black,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                        child: Text(
                          "Your Shopping Destination",
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                          style: primaryTextStyle(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Image(
                  image: const AssetImage('assets/images/ic_arrivals_2.jpg'),
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 200,
            child: sSAppButton(
              context: context,
              title: 'Start Shopping',
              onPressed: () {
                // FirebaseAuth.instance.currentUser != null ? DashBoardScreen().launch(context) : WelComeScreen().launch(context);
                // log("user already login");
              },
            ),
          )
        ],
      ),
    );
  }
}
