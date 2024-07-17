import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:noook/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: myIndigoMaterial,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: myIndigoMaterial),
  appBarTheme: AppBarTheme(
    color: fadedWhite,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: fadedWhite.withOpacity(0),
    ),
    surfaceTintColor: fadedWhite,
    titleTextStyle: const TextStyle(
      color: fadedBlack,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(
      color: fadedBlack,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: fadedWhite,
    selectedItemColor: myIndigo,
    elevation: 10.0,
  ),
  scaffoldBackgroundColor: fadedWhite,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: myIndigo,
    foregroundColor: fadedWhite,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16.0,
      color: fadedBlack,
      height: 1.4,
    ),
  ),
  fontFamily: 'Lato',
);

ThemeData darkTheme = ThemeData(
  primarySwatch: myIndigoMaterial,
  scaffoldBackgroundColor: fadedBlack,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: myIndigoMaterial),
  appBarTheme: AppBarTheme(
    titleSpacing: 20.0,
    color: fadedBlack,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: fadedBlack.withOpacity(0),
    ),
    surfaceTintColor: fadedBlack,
    titleTextStyle: const TextStyle(
      color: fadedWhite,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(
      color: fadedWhite,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: fadedBlack,
    selectedItemColor: myIndigo,
    elevation: 10.0,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: myIndigo,
    foregroundColor: fadedBlack,
  ),
  unselectedWidgetColor: Colors.grey,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16.0,
      color: fadedBlack,
      height: 1.4,
    ),
  ),
  cardColor: Colors.grey,
);
