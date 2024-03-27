import 'package:buzz/screen/DashBoardScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:buzz/screen/logInScreen.dart';
import 'package:buzz/utils/Widgets.dart';

import '../../../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 2));
    finish(context);
    const LoginScreen().launch(context, isNewTask: false);
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
                // const LoginScreen().launch(context);
                FirebaseAuth.instance.currentUser != null ? DashBoardScreen().launch(context) : LoginScreen().launch(context);
                log("user already login");
              },
            ),
          )
        ],
      ),
    );
  }
}
