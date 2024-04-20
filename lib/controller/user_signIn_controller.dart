import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../utils/app_constant.dart';


class UserSignInController extends GetxController{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //for password visibilty
  static var  isPasswordVisibile = true.obs;

  Future<UserCredential?> singInMethod(
      String userEmail,
      String userPassword,
      ) async {
    try {
      // EasyLoading.show(status: 'Please wait');
      UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(
          email: userEmail, password: userPassword,);

      // EasyLoading.dismiss();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      log("$e");
      Get.snackbar("Error", "$e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appSecondPrimaryColor,
          colorText: AppConstant.appTextColor);
    }
  }
}