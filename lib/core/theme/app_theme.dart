import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'check_box_theme.dart';


final ThemeData myAppTheme = ThemeData(
  primaryColor: const Color(0xFFFFFFFF),
  checkboxTheme: checkboxThemedata,
  textTheme: const TextTheme(
    labelMedium: TextStyle(
      fontSize: 20,
      color: Colors.white,
    ),
    labelSmall: TextStyle(
        fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400),
    headlineLarge: TextStyle(
      fontSize: 28,
      color: Colors.white,
    ),
    headlineMedium: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w700,
      color: AppColors.darkTextColor,
    ),
    bodySmall: TextStyle(
      fontSize: 16,
      color: AppColors.darkTextColor,
    ),
    bodyMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.darkTextColor,
    ),
    bodyLarge: TextStyle(
      fontSize: 20,
      color: AppColors.darkTextColor,
      fontWeight: FontWeight.w700,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    showUnselectedLabels: true,
    showSelectedLabels: true,
    selectedItemColor: Color(0xFF0E3158),
    unselectedItemColor: Color(0xFF0E3158),
    unselectedLabelStyle: TextStyle(
      color: Color(0xFF0E3158),
      fontSize: 12,
      fontFamily: 'SF Pro Display',
      fontWeight: FontWeight.w500,
      height: 0,
    ),
    selectedLabelStyle: TextStyle(
      color: Color(0xFF0E3158),
      fontSize: 12,
      fontFamily: 'SF Pro Display',
      fontWeight: FontWeight.w500,
      height: 0,
    ),
  ),
  appBarTheme: const AppBarTheme(
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: AppColors.darkTextColor,
        fontSize: 24,
        fontFamily: 'Lato',
        fontWeight: FontWeight.w700,
        height: 0.06,
      )),

      
);
