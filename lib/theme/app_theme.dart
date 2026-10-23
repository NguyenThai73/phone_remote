import 'package:flutter/material.dart';

class AppColors {
  static const ink = Color(0xFF19232D);
  static const muted = Color(0xFF89929A);
  static const orange = Color(0xFFFF653F);
  static const canvas = Color(0xFFF7F8FA);
  static const line = Color(0xFFE9ECEF);
}

ThemeData buildTheme() => ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: AppColors.canvas,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.orange,
    primary: AppColors.orange,
    surface: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.canvas,
    foregroundColor: AppColors.ink,
    elevation: 0,
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w800,
      color: AppColors.ink,
      letterSpacing: -0.8,
    ),
    headlineMedium: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w800,
      color: AppColors.ink,
      letterSpacing: -0.5,
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: AppColors.ink,
    ),
    titleMedium: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w700,
      color: AppColors.ink,
    ),
    bodyMedium: TextStyle(fontSize: 14, color: AppColors.ink),
  ),
);
