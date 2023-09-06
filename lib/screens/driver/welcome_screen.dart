import 'package:auth_project/controllers/authcontrollers/auth_controller.dart';
import 'package:auth_project/controllers/drivercontrollers/welcome_controller.dart';
import 'package:auth_project/utils/const.dart';
import 'package:auth_project/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key});

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              constraints: BoxConstraints(
                minHeight: 50,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                color: Colors.blue,
              ),
              child: Row(children: [
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.orange[500],
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
              ]),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.zero,
                child: GetBuilder<WelcomeController>(
                  init: WelcomeController(),
                  builder: (controller) {
                    if (controller.latitude != null &&
                        controller.longitude != null) {
                      return GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                              controller.latitude!, controller.longitude!),
                          zoom: 17,
                        ),
                        markers: Set<Marker>.from([
                          Marker(
                            markerId: MarkerId('marker_1'),
                            position: LatLng(
                                controller.latitude!, controller.longitude!),
                          ),
                        ]),
                      );
                    } else {
                      // Handle the case where latitude or longitude is null
                      return Center(
                        child: Loading(),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
