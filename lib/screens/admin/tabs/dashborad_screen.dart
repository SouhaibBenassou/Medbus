import 'package:auth_project/controllers/admincontrollers/setting_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    ClipOval(
                        clipBehavior: Clip.antiAlias,
                        child: GetBuilder<SettingController>(
                            init: SettingController(),
                            builder: (controller) {
                              return CachedNetworkImage(
                                imageUrl: controller.snUser.image!,
                                width: 60.0.w,
                                height: 60.0.h,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    const CircleAvatar(),
                              );
                            })),
                    GetBuilder<SettingController>(
                        init: SettingController(),
                        builder: (controller) {
                          return Text(
                            'Hi ,${controller.snUser.username}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          );
                        }),
                    12.verticalSpace,
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 155,
                  height: 148,
                  decoration: BoxDecoration(
                    color: Color(0xFFF6E7FF),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x33B07373),
                        offset: Offset(0, 2),
                        spreadRadius: 2,
                      )
                    ],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      12.verticalSpace,
                      Text(
                        'Available DRIVERS',
                        style: TextStyle(color: Colors.black),
                      ),
                      40.verticalSpace,
                      Text(
                        '14',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                15.horizontalSpace,
                Container(
                  width: 155,
                  height: 148,
                  decoration: BoxDecoration(
                    color: Color(0xFFF6E7FF),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x33B07373),
                        offset: Offset(0, 2),
                        spreadRadius: 2,
                      )
                    ],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      12.verticalSpace,
                      Text(
                        'Available BUS',
                        style: TextStyle(color: Colors.black),
                      ),
                      40.verticalSpace,
                      Text(
                        '14',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            20.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 155,
                  height: 148,
                  decoration: BoxDecoration(
                    color: Color(0xFFF6E7FF),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x33B07373),
                        offset: Offset(0, 2),
                        spreadRadius: 2,
                      )
                    ],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      12.verticalSpace,
                      Text(
                        'Total Drivers',
                        style: TextStyle(color: Colors.black),
                      ),
                      40.verticalSpace,
                      Text(
                        '14',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                15.horizontalSpace,
                Container(
                  width: 155,
                  height: 148,
                  decoration: BoxDecoration(
                    color: Color(0xFFF6E7FF),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x33B07373),
                        offset: Offset(0, 2),
                        spreadRadius: 2,
                      )
                    ],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      12.verticalSpace,
                      Text(
                        'REQUESTS',
                        style: TextStyle(color: Colors.black),
                      ),
                      40.verticalSpace,
                      Text(
                        '14',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
