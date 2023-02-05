import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';

class ThemeViewModel extends GetxController {
  bool isNavBarBottom = true;
  Color themeColor = Colors.white;
  Color themeTextColor = Colors.black;
  XFile? imagePP;

  void changeNavbar() {
    isNavBarBottom = !isNavBarBottom;
    update();
  }

  void updateImagePP(value) {
    imagePP = value;
    update();
  }

  changeThemeTextColor(Color value) {
    themeTextColor = value;
    update();
  }

  changeThemeColor(Color value) {
    themeColor = value;
    final double relativeLuminance = value.computeLuminance();

    const double kThreshold = 0.15;
    if ((relativeLuminance + 0.05) * (relativeLuminance + 0.05) > kThreshold) {
      themeTextColor = Colors.black;
    } else {
      themeTextColor = Colors.white;
    }
    update();
  }
}
