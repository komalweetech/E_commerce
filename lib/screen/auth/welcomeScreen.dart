import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:buzz/main.dart';
import 'package:buzz/screen/auth/user_signIn_screen.dart';
import 'package:buzz/utils/Widgets.dart';



class WelComeScreen extends StatelessWidget {
  const WelComeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _firebaseInitialization = Firebase.initializeApp();
    return Scaffold(
      body: Align(
        alignment: const Alignment(0.1, 0.4),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Image(
                image: AssetImage("assets/images/ic_logo.png"),
                height: 100,
                width: 100,
                // color: appStore.isDarkModeOn ? Colors.white : Colors.black,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16, width: 16),
              Text(
                "Your Shopping Destination",
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: primaryTextStyle(),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.32, width: 16),
              sSAppButton(
                color: appStore.isDarkModeOn ? Colors.black : Colors.white,
                context: context,
                textColor: appStore.isDarkModeOn ? Colors.white : Colors.black,
                title: 'Sign in',
                onPressed: () {
                  Get.to(const UserSignInScreen()) ;
                },
              ),
              const SizedBox(height: 16, width: 16),
              // sSAppButton(
              //   context: context,
              //   title: 'Sing UP',
              //   onPressed: () {
              //     Get.to(const UserSignUpScreen()) ;
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
