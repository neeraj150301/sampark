import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  void toggleTheme() {
    if (Get.isDarkMode) {
      Get.changeThemeMode(ThemeMode.light);
      isDarkMode(false);
    } else {
      Get.changeThemeMode(ThemeMode.dark);
      isDarkMode(true);
    }
  }
}
