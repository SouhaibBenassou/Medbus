import 'package:auth_project/controllers/authcontrollers/auth_controller.dart';
import 'package:auth_project/screens/admin/home_screen.dart';
import 'package:auth_project/screens/auth/login_screen.dart';

import 'package:auth_project/screens/driver/pending_screen.dart';
import 'package:auth_project/screens/driver/welcome_screen.dart';
import 'package:auth_project/utils/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/user.dart';

RxBool isLoading = false.obs;
TUser snUser = TUser();

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  login() async {
    verify().then((Value) {
      if (Value) {
        AuthController()
            .loginGmail(
                emailController.text.trim(), passwordController.text.trim())
            .then((value) {
          if (value.user == null) {
            Get.snackbar('Login', "t");
          } else {
            getUserFromDb(value.user!.uid).then((value) {
              print(value.type);
              if (value.type == 1) {
                Get.snackbar('login', 'success',
                    backgroundColor: Colors.green, colorText: Colors.white);
                Get.to(() => HomeScreen());
              } else if (value.type == 0 && value.status == 'pending') {
                Get.snackbar('login', 'success',
                    backgroundColor: Colors.green, colorText: Colors.white);
                Get.to(() => PendingScreen());
              } else if (value.type == 0 && value.status == 'approved') {
                Get.snackbar('login', 'success',
                    backgroundColor: Colors.green, colorText: Colors.white);
                Get.to(() => WelcomeScreen());
              } else
                () {
                  Get.snackbar('Error', 'the account not exiyrs');
                };
            });
          }
        });
      }
    });
  }

  verify() async {
    if (emailController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter your email',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } else if (!GetUtils.isEmail(emailController.text.trim())) {
      Get.snackbar('Error', "Enter a valid email address");
      return false;
    } else if (passwordController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter your password');
      return false;
    } else {
      return true;
    }
  }

  Future<TUser> getUserFromDb(uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      if (value.exists) snUser = TUser.fromJson(value.data()!);
    });
    return snUser;
  }

  void listenForAuthStateChanges() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        // User is logged in
        FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get()
            .then((DocumentSnapshot snapshot) {
          if (snapshot.exists) {
            // User document exists
            final userData = snapshot.data() as Map<String, dynamic>;
            final userStatus = userData['status'];
            final userType = userData['type'];
            if (userType == 0 && userStatus == 'approved') {
              // User is a driver
              Get.to(() => WelcomeScreen());
            } else if (userType == 0 && userStatus == 'pending') {
              // User is an admin
              Get.to(() => PendingScreen());
            } else if (userType == 1) {
              Get.to(() => HomeScreen());
            }
          } else {
            // User document does not exist
            Get.offAll(() => LoginScreen());
          }
        });
      } else {
        // User is not logged in
        Get.offAll(() => LoginScreen());
      }
    });
  }

  @override
  void onInit() {
    listenForAuthStateChanges() {
      isLoading.toggle();
      update();
    }

    super.onInit();
  }
}
