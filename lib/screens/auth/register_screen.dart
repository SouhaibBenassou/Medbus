import 'package:auth_project/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:auth_project/controllers/authcontrollers/register_controller.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff9E00FF),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: GetBuilder<RegisterController>(
              init: RegisterController(),
              builder: (controller) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/Vectorr.png', height: 120.h),
                    12.verticalSpace,
                    Image.asset('assets/Medbus.png', height: 15.h),
                    20.verticalSpace,
                    Text(
                      'Create you Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    12.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: GetBuilder<RegisterController>(
                              init: RegisterController(),
                              builder: (controller) {
                                return TextField(
                                  controller: controller.usernameController,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                      color: Color(0xffA4A4A4),
                                    ),
                                    border: InputBorder.none,
                                    hintText: 'Username',
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                    12.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: GetBuilder<RegisterController>(
                              init: RegisterController(),
                              builder: (controller) {
                                return TextField(
                                  controller: controller.emailController,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                      color: Color(0xffA4A4A4),
                                    ),
                                    border: InputBorder.none,
                                    hintText: 'Email',
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                    12.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: GetBuilder<RegisterController>(
                              init: RegisterController(),
                              builder: (controller) {
                                return TextField(
                                  controller: controller.phoneController,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                      color: Color(0xffA4A4A4),
                                    ),
                                    border: InputBorder.none,
                                    hintText: 'Phone',
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                    12.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0.w),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                child: GetBuilder<RegisterController>(
                                    init: RegisterController(),
                                    builder: (controller) {
                                      return DropdownButton<String>(
                                          style: TextStyle(color: Colors.black),
                                          hint: const Text(
                                            'Select an item',
                                            style: TextStyle(
                                                color: Color(0xffA4A4A4)),
                                          ),
                                          onChanged: (newValue) {
                                            controller.setSelectedDropdownItem(
                                                newValue!);
                                          },
                                          value:
                                              controller.selectedDropdownItem,
                                          items: controller.dropdownItems
                                              .map((String item) {
                                            return DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(item),
                                            );
                                          }).toList());
                                    }),
                              ),
                            ),
                          ),
                          GetBuilder<RegisterController>(
                              init: RegisterController(),
                              builder: (controller) {
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 2.w),
                                  child: InkWell(
                                    onTap: () {
                                      controller.chooseDate();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                      child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.w),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                DateFormat("dd-MM-yyyy")
                                                    .format(
                                                        controller.selectedDate)
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 16.sp,
                                                    color: Colors.black),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    controller.chooseDate();
                                                  },
                                                  icon: Icon(
                                                    Icons.calendar_month,
                                                  )),
                                            ],
                                          )),
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                    12.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: GetBuilder<RegisterController>(
                              init: RegisterController(),
                              builder: (controller) {
                                return TextField(
                                  obscureText: true,
                                  controller: controller.passwordController,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                      color: Color(0xffA4A4A4),
                                    ),
                                    border: InputBorder.none,
                                    hintText: 'Password',
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                    10.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: GetBuilder<RegisterController>(
                              init: RegisterController(),
                              builder: (controller) {
                                return TextField(
                                  obscureText: true,
                                  controller:
                                      controller.confirmpasswordController,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                      color: Color(0xffA4A4A4),
                                    ),
                                    border: InputBorder.none,
                                    hintText: 'Confirm Password',
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                    10.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 70.w),
                      child: GetBuilder<RegisterController>(
                          init: RegisterController(),
                          builder: (controller) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff4D0078),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              onPressed: () {
                                controller.createUser();
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15.h),
                                child: const Center(
                                  child: Text(
                                    'Sign up',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    17.verticalSpace,
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
