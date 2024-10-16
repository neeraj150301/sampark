import 'package:flutter/material.dart';
import 'package:sampark/config/colors.dart';

ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.light(
  background: const Color.fromARGB(255, 231, 231, 231),
  // primary: Colors.grey.shade500,
  primary: Color.fromARGB(255, 94, 106, 112),

  secondary: Colors.grey.shade300,
  tertiary: Colors.white,
  inversePrimary: Colors.grey.shade900,
));

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: dPrimaryColour,
      onPrimary: dBackgroundColour,
      background: dBackgroundColour,
      onBackground: dOnBackgroundColour,
      primaryContainer: dContainerColour,
      onPrimaryContainer: dOnContainerColour,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        color: dPrimaryColour,
        fontFamily: "Raleway",
        fontWeight: FontWeight.w800,
      ),
      headlineMedium: TextStyle(
        fontSize: 30,
        color: dOnBackgroundColour,
        fontFamily: "Raleway",
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: TextStyle(
        fontSize: 20,
        color: dOnBackgroundColour,
        fontFamily: "Raleway",
        fontWeight: FontWeight.w600,
      ),
    ));
