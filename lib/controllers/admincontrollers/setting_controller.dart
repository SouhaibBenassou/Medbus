import 'package:auth_project/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  var isLoading = false;
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

  @override
  void onInit() {
    getUserFromDb(FirebaseAuth.instance.currentUser!.uid).then((value) {
      snUser = value;
      isLoading = true;
      update();
    });
    super.onInit();
  }
}
