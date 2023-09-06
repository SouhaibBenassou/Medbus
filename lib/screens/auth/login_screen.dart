import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:auth_project/controllers/authcontrollers/login_controller.dart';
import 'package:auth_project/screens/auth/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff9E00FF),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset('assets/Vectorr.png', height: 120.w),
              12.verticalSpace,
              Image.asset('assets/Medbus.png', height: 15.w),
              45.verticalSpace,
              const Text(
                'Login to your account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
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
                    child: GetBuilder<LoginController>(
                        init: LoginController(),
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
              13.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: GetBuilder<LoginController>(
                        init: LoginController(),
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
              25.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 70.w),
                child: GetBuilder<LoginController>(
                    init: LoginController(),
                    builder: (controller) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff4D0078),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        onPressed: () {
                          controller.login();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          child: const Center(
                            child: Text(
                              'Sign in',
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
              25.verticalSpace,
              const Text(
                'Or sign in with',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              25.verticalSpace,
              InkWell(
                onTap: () {
                  Get.to(() => RegisterScreen());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        'Not yet a member?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    5.horizontalSpace,
                    Container(
                        child: Container(
                      child: Text('Sign in'),
                    ))
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
