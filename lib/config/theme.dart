import 'package:flutter/material.dart';
import 'package:sampark/config/colors.dart';

ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.light(
  background: const Color.fromARGB(255, 231, 231, 231),
  // primary: Colors.grey.shade500,
  primary: const Color.fromARGB(255, 94, 106, 112),

  secondary: Colors.grey.shade300,
  tertiary: Colors.white,
  inversePrimary: Colors.grey.shade900,
  onPrimaryContainer: const Color.fromARGB(255, 201, 199, 199),
));

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
  tertiary: Colors.black54,
  secondary: Colors.grey.shade300,

      primary: dPrimaryColour,
      onPrimary: Color(0xFF121212),
      background: dBackgroundColour,
      onBackground: dOnBackgroundColour,
      primaryContainer: dContainerColour,
      onPrimaryContainer: dOnContainerColour,
    ),
    scaffoldBackgroundColor: dBackgroundColour,
    appBarTheme: const AppBarTheme(
      backgroundColor: dContainerColour, // Darker app bar.
      titleTextStyle: TextStyle(
        color: dOnBackgroundColour, // Light text on app bar.
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      iconTheme: IconThemeData(color: dOnBackgroundColour), // Light icons.
    ),
    cardTheme: CardTheme(
      color: dContainerColour, // Darker gray for cards.
      shadowColor: Colors.black.withOpacity(0.3), // Subtle shadows for depth.
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
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
