import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark/config/theme.dart';
import 'package:sampark/firebase_options.dart';
import 'package:sampark/pages/welcomePage/welcome_page.dart';
import 'pages/authPage/auth_gate.dart';
import 'pages/splashPage/splashPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sampark',
      theme: lightTheme,
      // darkTheme: darkTheme,
      // themeMode: ThemeMode.dark,
      home: const AuthGate(),
    );
  }
}
