import 'package:flutter/material.dart';
import 'package:noook/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    elevation: 10.0,
    selectedItemColor: myIndigo,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
  ),
);
