import 'package:auth_project/controllers/admincontrollers/driver_controller.dart';
import 'package:auth_project/utils/const.dart';
import 'package:auth_project/utils/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DriverScreen extends StatelessWidget {
  const DriverScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DriversController>(
          init: DriversController(),
          builder: (controller) {
            return controller.isLoading == false
                ? Loading()
                : ListView.separated(
                    separatorBuilder: (context, index) => 5.verticalSpace,
                    itemCount: controller.listUser.length,
                    itemBuilder: (context, Index) {
                      final user = controller.listUser[Index];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.h),
                        child: Row(
                          children: [
                            Container(
                              width: 200.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                  color: Color(0xFFF6E7FF),
                                  borderRadius: BorderRadius.circular(10.r)),
                              child: Row(
                                children: [
                                  ClipOval(
                                      clipBehavior: Clip.antiAlias,
                                      child: CachedNetworkImage(
                                        imageUrl: user.image!,
                                        width: 35.0.w,
                                        height: 35.0.h,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            const CircleAvatar(),
                                      )),
                                  9.horizontalSpace,
                                  Text(
                                    user.username!,
                                    style: TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                            Spacer(),
                            8.horizontalSpace,
                            ElevatedButton(
                                style: elevatedButtonStyle,
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (
                                        builder,
                                      ) {
                                        return AlertDialog(
                                          backgroundColor: Color(0xFF9E00FF),
                                          title: Center(
                                              child: Text('Remove User')),
                                          content: Text(
                                            'are you sure want to remove the driver',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          actions: <Widget>[
                                            ElevatedButton(
                                              style: elevatedButtonStyle,
                                              child: Text('Confirm'),
                                              onPressed: () {
                                                controller.remove(user);
                                                Navigator.of(context).pop();
                                                Get.snackbar(
                                                    'Remove', 'succses',
                                                    backgroundColor:
                                                        Colors.green,
                                                    colorText: Colors.white);
                                              },
                                            ),
                                            ElevatedButton(
                                              style: elevatedButtonStyle,
                                              child: Text('Cancel'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: Text('Remove')),
                          ],
                        ),
                      );
                    });
          }),
    );
  }
}
