import 'package:auth_project/controllers/authcontrollers/register_controller.dart';
import 'package:auth_project/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RegisteImageScreen extends StatelessWidget {
  RegisteImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff9E00FF),
      body: SafeArea(
        child: Center(
            child: GetBuilder<RegisterController>(
          init: RegisterController(),
          builder: (controller) {
            return controller.isloading == false
                ? Loading()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: controller.image.value != null
                            ? Image.file(
                                controller.image.value!,
                                height: 100,
                                width: 500,
                              )
                            : Container(),
                      ),
                      2.verticalSpace, // Add spacing between the two widgets
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.cyan,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r))),
                        onPressed: () {
                          controller.selectImage();
                        },
                        child: Text(
                          'Upload Image ',
                        ),
                      ),
                      10.verticalSpace,

                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.cyan,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r))),
                          onPressed: () {
                            if (controller.image.value != null) {
                              controller.uploadToFirestore();
                              Get.snackbar(
                                'Success',
                                'the image has been add ',
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                              );
                            } else {
                              Get.snackbar('Submit', 'Please select the image',
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white);
                            }
                          },
                          child: Text('Submit'))
                    ],
                  );
          },
        )),
      ),
    );
  }
}
