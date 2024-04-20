import 'package:buzz/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../utils/app_constant.dart';

class UserSignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //for password visibilty
  static var  isPasswordVisibile = true.obs;

  Future<UserCredential?> signUpMethod(
      String userName,
      String userPhone,
      String userCity,
      String userEmail,
      String userPassword,
      // String sellerDeviceToken,
      ) async {
    try {
      EasyLoading.show(status: 'Please wait');
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
          email: userEmail, password: userPassword);
      //send email verification
      await userCredential.user!.sendEmailVerification();

      UserModel userModel = UserModel(
        // sellerDeviceToken: sellerDeviceToken,
        sId: userCredential.user!.uid,
        name: userName,
        phone: userPhone,
        city: userCity,
        email: userEmail,
        password: userPassword,
        isAdmin: false,
        isActive: true,
        createdOn: DateTime.now(),
      );

      // add this data to firebase store
      _firebaseFirestore.collection('user')
          .doc(userCredential.user?.uid)
          .set(userModel.toMap());
      EasyLoading.dismiss();
      return userCredential;

    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      Get.snackbar("Error", "$e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appSecondPrimaryColor,
          colorText: AppConstant.appTextColor);
    }
  }
}

