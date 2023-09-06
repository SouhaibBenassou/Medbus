import 'dart:async';

import 'package:auth_project/controllers/authcontrollers/auth_controller.dart';
import 'package:auth_project/model/user.dart';
import 'package:auth_project/screens/auth/login_screen.dart';
import 'package:auth_project/screens/driver/pending_screen.dart';
import 'package:auth_project/screens/auth/registerimage_screen.dart';
import 'package:auth_project/utils/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RegisterController extends GetxController {
  RxBool isloading = true.obs;
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController newValue = TextEditingController();
  DateTime? dateOfBirth;
  var selectedDate = DateTime.now();

  chooseDate() async {
    dateOfBirth = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate,
      firstDate: DateTime(1960),
      lastDate: DateTime(2024),
      // ... other properties
      // Change the color of the DatePicker
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: const Color(0xff9E00FF), // Set primary color
              onPrimary: Colors.white, // Set text color on primary color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: const Color(0xff9E00FF), // Set text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    @override
    void onInit() {
      super.onInit();
    }

    @override
    void onReady() {
      super.onReady();
    }

    @override
    void onClose() {}

    if (dateOfBirth != null && dateOfBirth != selectedDate) {
      selectedDate = dateOfBirth!;

      print(dateOfBirth);
      update();
    } else {
      print('Date not selected');
    }
  }

  bool disableDate(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(Duration(days: 5))))) {
      return true;
    }
    return false;
  }

  List<String> dropdownItems = ['Male', 'Female'];
  String? selectedDropdownItem;

  void setSelectedDropdownItem(String newValue) {
    selectedDropdownItem = newValue;
    update();
  }

  createUser() {
    verify().then((Value) async {
      if (Value) {
        TUser t_user = TUser(
          username: usernameController.text,
          email: emailController.text,
          date: dateOfBirth.toString(),
          gender: selectedDropdownItem,
          phone: phoneController.text,
          type: 0,
          status: 'pending',
          image: '',
        );
        await AuthController()
            .registerUserAndAddToCollection(t_user, passwordController.text)
            .then((value) {
          if (value) {
            Get.snackbar('register', 'success',
                backgroundColor: Colors.green, colorText: Colors.white);
            Get.to(() => RegisteImageScreen(),
                transition: Transition.leftToRightWithFade,
                duration: const Duration(milliseconds: 500));
          }
        });
      }
    });
  }

  verify() async {
    if (usernameController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter your username',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } else if (emailController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter your email',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } else if (!GetUtils.isEmail(emailController.text.trim())) {
      Get.snackbar('Error', "Enter a valid email address",
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } else if (phoneController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter your phone',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } else if (dateOfBirth == DateTime.now()) {
      Get.snackbar('Error ', 'Please enter your birth date ',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } else if (passwordController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter your password',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } else if (confirmpasswordController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter your confirm password',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } else if (passwordController.text != confirmpasswordController.text) {
      Get.snackbar('Error', 'password does not match',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } else {
      return true;
    }
  }

  final picker = ImagePicker();
  final Rx<File?> image = Rx<File?>(null);
  Future<void> selectImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
      update();
    }
    throw Exception('No image selected');
  }

  Future<void> uploadToFirestore() async {
    if (image.value != null) {
      final file = image.value!;
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      try {
        FirebaseAuth auth = FirebaseAuth.instance;
        User? user = auth.currentUser;
        if (user != null) {
          String currentUserId = user.uid;
          String folderName =
              'images/pictures/$currentUserId'; // Folder name with current user ID

          Reference storageReference =
              FirebaseStorage.instance.ref().child('$folderName/$fileName');
          await storageReference.putFile(file);
          String imageUrl = await storageReference.getDownloadURL();

          CollectionReference usersCollection =
              FirebaseFirestore.instance.collection('users');
          DocumentReference documentRef = usersCollection.doc(currentUserId);
          await documentRef.update({'image': imageUrl});

          // Perform further operations with the imageUrl if needed
          print('Image uploaded successfully. URL: $imageUrl');
          Get.to(() => LoginScreen());
        } else {
          print('User is not authenticated.');
          // Handle the case when the user is not authenticated
        }
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
  }

  @override
  void onInit() {
    Loading();
    update();
    super.onInit();
  }
}
