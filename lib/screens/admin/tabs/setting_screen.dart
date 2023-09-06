import 'package:auth_project/controllers/admincontrollers/setting_controller.dart';
import 'package:auth_project/controllers/authcontrollers/auth_controller.dart';
import 'package:auth_project/utils/const.dart';
import 'package:auth_project/utils/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: GetBuilder<SettingController>(
          init: SettingController(),
          builder: (controller) {
            return controller.isLoading == false
                ? Loading()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          radius: 60,
                          child: Container(
                            width: 240,
                            height: 240,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF9E00FF),
                                width: 2,
                              ),
                            ),
                            child: ClipOval(
                              clipBehavior: Clip.antiAlias,
                              child: GetBuilder<SettingController>(
                                  init: SettingController(),
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
                      GetBuilder<SettingController>(
                          init: SettingController(),
                          builder: (controller) {
                            return Center(
                                child: Text(
                              '${controller.snUser.username}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ));
                          }),
                      Text(
                        'admin',
                        style: TextStyle(color: Colors.orange),
                      ),
                      5.verticalSpace,
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 36.h,
                          width: 160.w,
                          child: Center(
                            child: Text(
                              'EDIT PROFILE',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Color(0xfff6E7FF),
                              borderRadius: BorderRadius.circular(10.r)),
                        ),
                      ),
                      12.verticalSpace,
                      // Container(
                      //   height: 150.h,
                      //   width: 280.w,
                      //   decoration: BoxDecoration(
                      //     color: Color(0xfff6E7FF),
                      //     borderRadius: BorderRadius.circular(10.r),

                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.h),
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.h),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: 27.sp,
                                  color: Color(0xFF9E00FF),
                                ),
                                5.horizontalSpace,
                                GetBuilder<SettingController>(
                                    init: SettingController(),
                                    builder: (controller) {
                                      return Text(
                                        '${controller.snUser.phone}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.sp),
                                      );
                                    })
                              ],
                            ),
                          ),
                          height: 55.h,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xFF9E00FF), width: 1.w),
                              color: Color(0xffF6E7FF),
                              borderRadius: BorderRadius.circular(100.r)),
                        ),
                      ),
                      6.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.h),
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.h),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.email,
                                  size: 27.sp,
                                  color: Color(0xFF9E00FF),
                                ),
                                5.horizontalSpace,
                                GetBuilder<SettingController>(
                                    init: SettingController(),
                                    builder: (controller) {
                                      return Text(
                                        '${controller.snUser.email}',
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          color: Colors.black,
                                        ),
                                      );
                                    })
                              ],
                            ),
                          ),
                          height: 55.h,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xFF9E00FF), width: 1.w),
                              color: Color(0xffF6E7FF),
                              borderRadius: BorderRadius.circular(100.r)),
                        ),
                      ),
                      12.verticalSpace,
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Color(0xff9E00FF),
                                title: const Text(
                                  'Logout',
                                  style: TextStyle(color: Colors.white),
                                ),
                                content:
                                    const Text('are you sure want to logout?'),
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
                        child: Container(
                          height: 36.h,
                          width: 160.w,
                          child: Center(
                            child: Text(
                              'Logout ',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10.r)),
                        ),
                      ),
                    ],
                  );
          },
        ),
      )),
    );
  }
}
