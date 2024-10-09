import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark/config/theme.dart';
import 'package:sampark/pages/welcomePage/welcome_page.dart';

import 'pages/splashPage/splashPage.dart';

void main() {
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
      home: const WelcomePage(),
    );
  }
}
