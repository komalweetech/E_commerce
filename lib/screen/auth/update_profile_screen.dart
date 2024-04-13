import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../utils/app_constant.dart';
import '../home/DashBoardScreen.dart';



class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late TextEditingController userName;
  late TextEditingController userPhone;
  late TextEditingController userCity;
  late TextEditingController userEmail;
  late TextEditingController userPassword;

  @override
  void initState() {
    super.initState();

    userName = TextEditingController();
    userPhone = TextEditingController();
    userCity = TextEditingController();
    userEmail = TextEditingController();
    userPassword = TextEditingController();

    fetchData();
  }

  @override
  void dispose() {
    userName.dispose();
    userPhone.dispose();
    userCity.dispose();
    userEmail.dispose();
    userPassword.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      DocumentSnapshot snapshot = await _firestore.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        setState(() {
          userName.text = data['name'] ?? '';
          userPhone.text = data['phone'] ?? '';
          userCity.text = data['city'] ?? '';
          userEmail.text = data['email'] ?? '';
          userPassword.text = data['password'] ?? '';
        });
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appSecondPrimaryColor,
        title: const Text(
          "Update Profile data",
          style: TextStyle(color: AppConstant.appTextColor),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: userName,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  TextFormField(
                    controller: userPhone,
                    decoration: InputDecoration(labelText: 'Phone Number'),
                  ),
                  TextFormField(
                    controller: userCity,
                    decoration: InputDecoration(labelText: 'City'),
                  ),
                  TextFormField(
                    controller: userEmail,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  TextFormField(
                    controller: userPassword,
                    decoration: InputDecoration(labelText: 'Password'),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppConstant.appPrimaryColor),
                    onPressed: () async {
                      await FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).update({
                        'name': userName.text,
                        'phone': userPhone.text,
                        'city': userCity.text,
                        'email': userEmail.text,
                        'password': userPassword.text,
                        // Update any other fields here
                      });
                      Get.snackbar("Update", "Update your profile ",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppConstant.appSecondPrimaryColor,
                          colorText: AppConstant.appTextColor);
                      Get.to(DashBoardScreen());
                    },
                    child: const Text('Update',style: TextStyle(color: AppConstant.appTextColor),),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

          ],
        ),
      ),
    );
  }
}
