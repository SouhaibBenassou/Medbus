
import 'package:auth_project/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestController extends GetxController {
  TUser snUser = TUser();
  List<TUser> listUser = [];
  var isLoading = false;

  Future<List<TUser>> getUserFromDb() async {
    final collection =
        await FirebaseFirestore.instance.collection('users').get();
    List<TUser> listUser = [];

    if (collection != null) {
      for (var doc in collection.docs.map((doc) => doc.data()).toList()) {
        if (doc != null) {
          snUser = TUser.fromJson(doc);
          if (snUser.status == 'pending') {
            listUser.add(snUser);
          }
        }
      }
    }
    return listUser;
  }

  @override
  void onInit() {
    getUserFromDb().then((value) {
      listUser = value;
      isLoading = true;
      update();
    });
    super.onInit();
  }

  // Update the user status to 'approved'

  updateStatus(TUser user) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .update({"status": "approved"});
    update();
    Get.snackbar('approve', 'the driver has been approved ',
        backgroundColor: Colors.green, colorText: Colors.white);
  }

  remove(TUser user) async {
    await FirebaseFirestore.instance.collection("users").doc(user.uid).delete();
    update();
    Get.snackbar('Remove', 'the driver has been Removed ',
        backgroundColor: Colors.green, colorText: Colors.white);
  }
}
