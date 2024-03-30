import 'package:buzz/screen/logInScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:buzz/main.dart';
import 'package:buzz/utils/Widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key,});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {

  final TextEditingController userController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController conformPassController = TextEditingController();


  void createAccount() async {
    String userName = userController.text.trim();
    String phoneNumber = numberController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confPassword = conformPassController.text.trim();

    if (userName == "" ||
        phoneNumber == "" ||
        email == "" ||
        password == "" ||
        confPassword == "") {
      Fluttertoast.showToast(msg: "Please Fill all the Details");
      log("Please Fill all the Details");
    } else if (password != confPassword) {
      Fluttertoast.showToast(
          msg: "Password do not match with Conform Password",);
      log("Password do not match with Conform Password");
    } else {
      try{
        //create account with email & password.
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        Fluttertoast.showToast(msg: "User created");
        log("User created");
        if(userCredential.user != null) {
          Navigator.pop(context);
        }
      }on FirebaseAuthException catch(ex) {
        //  if user already created.
        Fluttertoast.showToast(msg: "User created");
        log(ex.code.toString());
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(color: Color(0x00000000), width: 1),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: context.iconColor, size: 20),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 32),
            Text(
              "Register",
              textAlign: TextAlign.start,
              overflow: TextOverflow.clip,
              style: boldTextStyle(size: 18),
            ),
            const SizedBox(height: 8),
            Text(
              "Create your new account",
              textAlign: TextAlign.start,
              overflow: TextOverflow.clip,
              style: primaryTextStyle(),
            ),
            const SizedBox(height: 32),
            TextField(
              controller: userController,
              obscureText: false,
              textAlign: TextAlign.start,
              maxLines: 1,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 14,
              ),
              decoration: sSInputDecoration(
                context: context,
                name: 'User name',
                icon: Icon(Icons.email,
                    color: Colors.grey.withOpacity(0.4), size: 24),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: numberController,
              obscureText: false,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.number,
              maxLines: 1,
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14),
              decoration: sSInputDecoration(
                context: context,
                name: 'Mobile',
                icon: Icon(Icons.call,
                    color: Colors.grey.withOpacity(0.4), size: 24),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              obscureText: false,
              textAlign: TextAlign.start,
              maxLines: 1,
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 14),
              decoration: sSInputDecoration(
                context: context,
                name: 'Email address',
                icon: Icon(Icons.email,
                    color: Colors.grey.withOpacity(0.4), size: 24),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: false,
              textAlign: TextAlign.start,
              maxLines: 1,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 14,
              ),
              decoration: sSInputDecoration(
                context: context,
                name: 'Password',
                icon: Icon(Icons.lock,
                    color: Colors.grey.withOpacity(0.4), size: 24),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: conformPassController,
              obscureText: false,
              textAlign: TextAlign.start,
              maxLines: 1,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 14,
              ),
              decoration: sSInputDecoration(
                context: context,
                name: 'Conform Password',
                icon: Icon(Icons.lock,
                    color: Colors.grey.withOpacity(0.4), size: 24),
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  createAccount();
                },
                child: Container(
                  margin: const EdgeInsets.all(0),
                  padding: const EdgeInsets.all(0),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: appStore.isDarkModeOn
                        ? context.cardColor
                        : const Color(0xff010101),
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: const Color(0x4df2e4e4), width: 1),
                  ),
                  child: const Icon(Icons.arrow_forward,
                      color: Color(0xfffcfdff), size: 24),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Already have an account?",
              textAlign: TextAlign.start,
              overflow: TextOverflow.clip,
              style: primaryTextStyle(),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () {
                // finish(context);
                const LoginScreen().launch(context);
              },
              child: Text(
                "Log In",
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: boldTextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
