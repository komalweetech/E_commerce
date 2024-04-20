import 'package:buzz/controller/user_signIn_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:buzz/screen/home/DashBoardScreen.dart';
import 'package:buzz/screen/auth/ForgotPasswordScreen.dart';
import 'package:buzz/screen/auth/user_signUp_screen.dart';

import '../../utils/app_constant.dart';

class UserSignInScreen extends StatefulWidget {
  const UserSignInScreen({
    super.key,
  });

  @override
  State<UserSignInScreen> createState() => _UserSignInScreenState();
}

class _UserSignInScreenState extends State<UserSignInScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final UserSignInController userSignInController =
        Get.put(UserSignInController());

    TextEditingController userEmail = TextEditingController();
    TextEditingController userPassword = TextEditingController();

    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return WillPopScope(
          onWillPop: () async {
            return await _onBackPressed(context);
          },
          child: Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(
                color: AppConstant.appTextColor,
              ),
              backgroundColor: AppConstant.appSecondPrimaryColor,
              title: const Text(
                "SignIn",
                style: TextStyle(color: AppConstant.appTextColor),
              ),
              centerTitle: true,
            ),
            body: Container(
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height / 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      width: Get.width,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: userEmail,
                          cursorColor: AppConstant.appSecondPrimaryColor,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: "Email",
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      width: Get.width,
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Obx(
                            () => TextFormField(
                              controller: userPassword,
                              obscureText:
                                  UserSignInController.isPasswordVisibile.value,
                              cursorColor: AppConstant.appSecondPrimaryColor,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  prefixIcon: Icon(Icons.password),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      UserSignInController.isPasswordVisibile
                                          .toggle();
                                    },
                                    child: UserSignInController
                                            .isPasswordVisibile.value
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.visibility),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0))),
                            ),
                          )),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () => Get.offAll(const ForgotPasswordScreen()),
                        child: const Text(
                          "Forget Password",
                          style: TextStyle(
                              color: AppConstant.appSecondPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height / 40,
                    ),
                    Material(
                        child: Container(
                      width: Get.width / 1.2,
                      height: Get.height / 15,
                      decoration: BoxDecoration(
                        color: AppConstant.appSecondPrimaryColor,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: TextButton(
                        child: const Text(
                          "SIGN IN",
                          style: TextStyle(
                              color: AppConstant.appTextColor, fontSize: 17),
                        ),
                        onPressed: () async {
                          String email = userEmail.text.trim();
                          String password = userPassword.text.trim();

                          if (email.isEmpty || password.isEmpty) {
                            log("Please Fill all the Details");
                            Get.snackbar("Error", "Please Enter all Details ",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor:
                                    AppConstant.appSecondPrimaryColor,
                                colorText: AppConstant.appTextColor);
                          } else {
                            log("userCredential");
                            UserCredential? userCredential =
                                await userSignInController.singInMethod(
                                    email, password);

                            if (userCredential != null) {
                              log("login successfuly");
                              Get.snackbar("Success", "login Successfully ",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor:
                                      AppConstant.appSecondPrimaryColor,
                                  colorText: AppConstant.appTextColor);
                              Get.offAll(() => DashBoardScreen());
                            } else {
                              Get.snackbar("Error", "Please try again",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor:
                                      AppConstant.appSecondPrimaryColor,
                                  colorText: AppConstant.appTextColor);
                            }
                          }
                        },
                      ),
                    )),
                    SizedBox(
                      height: Get.height / 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                              color: AppConstant.appSecondPrimaryColor),
                        ),
                        GestureDetector(
                          onTap: () => Get.offAll(UserSignUpScreen()),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                                color: AppConstant.appSecondPrimaryColor),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirm Exit'),
            content: const Text('Are you sure you want to exit?'),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstant.appPrimaryColor),
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text(
                  'No',
                  style: TextStyle(color: AppConstant.appTextColor),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstant.appPrimaryColor),
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text(
                  'Yes',
                  style: TextStyle(color: AppConstant.appTextColor),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }
}
