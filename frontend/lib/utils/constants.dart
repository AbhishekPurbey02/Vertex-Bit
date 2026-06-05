import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF0F2B5B);
  static const Color primaryLight = Color(0xFF2563EB);
  static const Color accent = Color(0xFFDC2626);
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF8F9FA);
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textGray = Color(0xFF666666);
  static const Color textLight = Color(0xFF999999);
}

class AppStrings {
  static const String companyName = 'Vertex Bit';
  static const String tagline =
      'Your vision is brought to life with precision and excellence.';
  static const String location = 'Based in Nepal - Serving Globally';
  static const String email = 'hello@vertexbit.com';
  static const String phone = 'Available on request';
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:5000/api',
  );
}
