import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;


  @override
  void onInit() {
    super.onInit();
    _loadThemeFromPrefs(); // Load theme mode when the controller is initialized
  }

  void toggleTheme() async {
    if (Get.isDarkMode) {
      Get.changeThemeMode(ThemeMode.light);
      isDarkMode(false);
      await _saveThemeToPrefs(false);
    } else {
      Get.changeThemeMode(ThemeMode.dark);
      isDarkMode(true);
      await _saveThemeToPrefs(true);
    }
  }

    // Save theme preference
  Future<void> _saveThemeToPrefs(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDark);
  }
  
    // Load theme preference
  Future<void> _loadThemeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    isDarkMode.value = prefs.getBool('isDarkMode') ?? false;
    if (isDarkMode.value) {
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      Get.changeThemeMode(ThemeMode.light);
    }
  }
  
}
