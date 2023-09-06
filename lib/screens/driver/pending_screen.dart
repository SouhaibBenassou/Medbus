import 'package:auth_project/controllers/authcontrollers/auth_controller.dart';
import 'package:auth_project/controllers/drivercontrollers/pending_controller.dart';
import 'package:auth_project/controllers/drivercontrollers/welcome_controller.dart';
import 'package:auth_project/utils/const.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PendingScreen extends StatelessWidget {
  PendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff9E00FF),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Color(0xff9E00FF),
                            title: const Text(
                              'Logout',
                              style: TextStyle(color: Colors.white),
                            ),
                            content: const Text('are you sure want to logout?'),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 20),
                            titlePadding: const EdgeInsets.only(
                                left: 24,
                                right: 24,
                                top: 24), // Customize title padding
                            actions: [
                              ElevatedButton(
                                style: elevatedButtonStyle,
                                child: const Text('Close'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              GetBuilder<AuthController>(
                                init: AuthController(),
                                builder: (controller) {
                                  return ElevatedButton(
                                    style: elevatedButtonStyle,
                                    child: const Text('Logout'),
                                    onPressed: () {
                                      controller.logout();
                                    },
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              50.verticalSpace,
              Image.asset('assets/Vectorr.png', height: 120.h),
              12.verticalSpace,
              Image.asset('assets/Medbus.png', height: 15.h),
              80.verticalSpace,
              CircleAvatar(
                  radius: 60,
                  child: Container(
                    width: 240,
                    height: 240,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xff9E00FF),
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      clipBehavior: Clip.antiAlias,
                      child: GetBuilder<PendingController>(
                          init: PendingController(),
                          builder: (controller) {
                            return CachedNetworkImage(
                              imageUrl: controller.snUser.image!,
                              width: 236.w,
                              height: 236.h,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const CircleAvatar(),
                            );
                          }),
                    ),
                  )),
              12.verticalSpace,
              GetBuilder<PendingController>(
                  init: PendingController(),
                  builder: (controller) {
                    return Text(
                      controller.snUser.username!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    );
                  }),
              GetBuilder<PendingController>(
                  init: PendingController(),
                  builder: (controller) {
                    return Text(
                      controller.snUser.email!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    );
                  }),
              50.verticalSpace,
              Text('your request under review'),
            ],
          ),
        ),
      ),
    );
  }
}
