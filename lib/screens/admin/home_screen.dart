import 'package:auth_project/controllers/authcontrollers/auth_controller.dart';
import 'package:auth_project/screens/admin/tabs/dashborad_screen.dart';
import 'package:auth_project/screens/admin/tabs/driver_screen.dart';
import 'package:auth_project/screens/admin/tabs/request_screen.dart';
import 'package:auth_project/screens/admin/tabs/setting_screen.dart';
import 'package:auth_project/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
    DriverScreen(),
    RequestScreen(),
    SettingsScreen(),
  ];
  static List<String> _appBarTitles = [
    'Home',
    'Drivers',
    'Requests',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff9E00FF),
        // Set the background color to cyan
        centerTitle: true,
        automaticallyImplyLeading: false, // Center the title
        title: Text(
          _appBarTitles[_selectedIndex],
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
       
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.w),
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 8.h),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Color(0xff9E00FF),
              iconSize: 24.sp,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.cyan,
              color: Colors.grey[400],
              tabs: [
                GButton(
                  backgroundColor: Colors.grey[100]!,
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  backgroundColor: Colors.grey[100]!,
                  icon: Icons.drive_eta,
                  text: 'drivers',
                ),
                GButton(
                  backgroundColor: Colors.grey[100]!,
                  icon: Icons.request_quote,
                  text: 'requests',
                ),
                GButton(
                  backgroundColor: Colors.grey[100]!,
                  icon: Icons.settings,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
