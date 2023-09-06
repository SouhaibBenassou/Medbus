import 'dart:async';


import 'package:auth_project/screens/auth/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../model/user.dart';


class WelcomeController extends GetxController {
  RxBool isloading = false.obs;
  Position? position;
  double? latitude;
  double? longitude; 
  StreamSubscription<Position> positionStream =
      Geolocator.getPositionStream().listen((Position? position) {
    //   longitude = position.longitude;
    print(position == null
        ? 'Unknown'
        : '${position.latitude.toString()}, ${position.longitude.toString()}');
  });
  


  Stream<void> updateLatAndLong(
      TUser user, double? latitude, double? longitude) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .snapshots()
        .asyncMap((snapshot) async {
      if (snapshot.exists) {
        await snapshot.reference
            .update({"longitude": longitude, "latitude": latitude});
      }
    });
  }
  TUser snUser = TUser();

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

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> logout() async {
    await _auth.signOut();
    Get.offAll(
      () => const LoginScreen(),
    );
    // Add navigation logic here to navigate to the login screen or any other desired screen
  }

  RxBool switchValue = false.obs;

  void updateSwitchValue(bool newValue) {
    switchValue.value = newValue;
    update();
  }

  @override
  void onInit() {
    isloading.toggle();

    // Get the current position
    Geolocator.getCurrentPosition().then((position) {
      // Update the latitude and longitude variables
      latitude = position.latitude;
      longitude = position.longitude;

      // Print the latitude and longitude for debugging
      print(latitude);
      print(longitude);
 // Fetch the user data from Firestore
      getUserFromDb(FirebaseAuth.instance.currentUser!.uid).then((value) {
        snUser = value;
        update();
      });
  // Update the UI
      update();
    });

    super.onInit();
  }
}
