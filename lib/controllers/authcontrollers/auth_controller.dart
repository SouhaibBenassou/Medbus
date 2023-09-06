import 'package:auth_project/model/user.dart';
import 'package:auth_project/screens/auth/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AuthController extends GetxController {
  var isloading = false;
  Future<UserCredential> loginGmail(
      String emailAddress, String password) async {
    var user;
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password)
          .then((value) => user = value);
      return user;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        Get.snackbar(
          'Login',
          'User not found ',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          'Login',
          'Wrong password',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      return user;
    }
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> registerUserAndAddToCollection(TUser t_user, password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: t_user.email!.trim(),
        password: password,
      );

      User? newUser = userCredential.user;
      if (newUser != null) {
        t_user.uid = newUser.uid;

        await FirebaseFirestore.instance
            .collection('users')
            .doc(newUser.uid)
            .set(t_user.toJson())
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));
      }

      return true;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'weak-password') {
        Get.snackbar(
          'About Register',
          'The password provided is too weak.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar(
          'About Register',
          'The account already exists for that email.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      return false;
    } catch (error) {
      print('Failed to register user and add to collection: $error');
      return false;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    Get.offAll(
      () => const LoginScreen(),
    );
    Get.snackbar("Logout", "Success",
        backgroundColor: Colors.green, colorText: Colors.white);
    update();
    // Add navigation logic here to navigate to the login screen or any other desired screen
  }

  updateUserInCollection(TUser  t_user, String currentUserId) {}
}
