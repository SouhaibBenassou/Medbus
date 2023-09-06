import 'package:flutter/material.dart';

ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
  primary: Color(0xFFF6E7FF), // Set the background color of the button
  onPrimary: Colors.black, // Set the text color of the button
  elevation: 5, // Set the elevation (shadow) of the button
  shape: RoundedRectangleBorder(
    borderRadius:
        BorderRadius.circular(10), // Set the border radius of the button
  ),
);
