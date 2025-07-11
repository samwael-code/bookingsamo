import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AppColors {
  static const Color primaryColor = Color(0xff031e40); // deep blue
  static const Color whiteColor = Colors.white;
  static const Color yellowColor = Color(0xFFFFD700); // gold
  static const Color bgDarktColor = Color(0xFFF0F0F0); // light grey
}

class AppSizes {
  static const double size14 = 14.0;
  static const double size16 = 16.0;
  static const double size18 = 18.0;
  static const double size20 = 20.0;
  static const double size22 = 22.0;
  static const double size24 = 24.0;
}

class AppAssets {
  static const String icProfile = 'assets/images/profile.png'; // update as needed
}

class AppStyle {
  static Text normal({
    required String title,
    double size = AppSizes.size16,
    Color color = Colors.black,
  }) {
    return Text(
      title,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  static Text bold({
    required String title,
    double size = AppSizes.size18,
    Color color = Colors.black,
  }) {
    return Text(
      title,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

// Extensions for spacing (velocity_x package must be added)
extension SizedBoxHelpers on num {
  SizedBox get widthBox => SizedBox(width: toDouble());
  SizedBox get heightBox => SizedBox(height: toDouble());
}
