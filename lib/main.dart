import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark/config/theme.dart';
import 'package:sampark/firebase_options.dart';
import 'package:sampark/pages/welcomePage/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controller/theme_controller.dart';
import 'pages/authPage/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  await firebaseMessaging.requestPermission();

  // String? fcmToken = await FirebaseMessaging.instance.getToken();
  // print(fcmToken);
  final prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  runApp(MyApp(isFirstTime: isFirstTime));
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;

  const MyApp({super.key, required this.isFirstTime});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());

    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Sampark',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeController.isDarkMode.value
              ? ThemeMode.dark
              : ThemeMode.light,
          home: isFirstTime ? const WelcomePage() : const AuthGate(),
        ));
  }
}
