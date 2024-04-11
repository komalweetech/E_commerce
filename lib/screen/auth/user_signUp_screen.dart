
import 'package:buzz/controller/user_signUp_controller.dart';
import 'package:buzz/screen/auth/user_signIn_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/app_constant.dart';

class UserSignUpScreen extends StatefulWidget {
  const UserSignUpScreen({super.key});

  @override
  State<UserSignUpScreen> createState() => _UserSignUpScreenState();
}

class _UserSignUpScreenState extends State<UserSignUpScreen> {
  final UserSignUpController userSignUpController = Get.put(UserSignUpController());

  TextEditingController userName = TextEditingController();
  TextEditingController userPhone = TextEditingController();
  TextEditingController userCity = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appSecondPrimaryColor,
        title: const Text(
          "SingUp",
          style: TextStyle(color: AppConstant.appTextColor),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Get.height /20,),
              Container(
                alignment: Alignment.center,
                child: const Text("Welcome to The app",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,color: AppConstant.appSecondPrimaryColor),),
              ),
              SizedBox(height: Get.height /20,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    controller: userName,
                    cursorColor: AppConstant.appSecondPrimaryColor,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        hintText: "UserName",
                        prefixIcon: Icon(Icons.person),
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
                  child: TextFormField(
                    controller: userPhone,
                    cursorColor: AppConstant.appSecondPrimaryColor,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Phone Number",
                        prefixIcon: Icon(Icons.phone),
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
                  child: TextFormField(
                    controller: userCity,
                    cursorColor: AppConstant.appSecondPrimaryColor,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: "city",
                        prefixIcon: Icon(Icons.location_on),
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
                        obscureText: UserSignUpController.isPasswordVisibile.value,
                        cursorColor: AppConstant.appSecondPrimaryColor,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: Icon(Icons.password),
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  UserSignUpController.isPasswordVisibile.toggle();
                                },
                                child:UserSignUpController.isPasswordVisibile.value ?
                                Icon(Icons.visibility_off) : Icon(Icons.visibility)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                    )
                ),
              ),
              SizedBox(height: Get.height / 40,),
              Material(
                  child: Container(
                    width: Get.width /2,
                    height: Get.height / 18,
                    decoration: BoxDecoration(
                      color: AppConstant.appSecondPrimaryColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: TextButton(
                      child: Text("SIGN Up",style: TextStyle(color: AppConstant.appTextColor,fontSize: 17),),
                      onPressed: () async {
                        String name = userName.text.trim();
                        String phone = userPhone.text.trim();
                        String city = userCity.text.trim();
                        String email = userEmail.text.trim();
                        String password = userPassword.text.trim();
                        String sellerDeviceToken = " ";

                        if(name.isEmpty || phone.isEmpty || city.isEmpty || phone.isEmpty || password.isEmpty) {
                          Get.snackbar("Error", "Please Enter all Details ",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appSecondPrimaryColor,
                              colorText: AppConstant.appTextColor);
                        }else{
                          UserCredential? userCredential = await userSignUpController.signUpMethod(
                            name,
                            phone,
                            city,
                            email,
                            password,
                            // sellerDeviceToken
                          );

                          if(userCredential != null) {
                            Get.snackbar("Verification Email sent.", "Please Check your Email.",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.appSecondPrimaryColor,
                                colorText: AppConstant.appTextColor);

                            FirebaseAuth.instance.signOut();

                            Get.offAll(() => UserSignInScreen());
                          }
                        }

                      },
                    ),
                  )
              ),
              SizedBox(height: Get.height / 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",
                    style: TextStyle(color: AppConstant.appSecondPrimaryColor),),
                  GestureDetector(
                    onTap: () => Get.offAll(UserSignInScreen()),
                    child: Text("Sign in",
                      style: TextStyle(color: AppConstant.appSecondPrimaryColor),),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
