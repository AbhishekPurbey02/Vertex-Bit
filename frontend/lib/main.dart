import 'package:flutter/material.dart';
import 'screens/contact_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const VertexBitApp());
}

class VertexBitApp extends StatelessWidget {
  const VertexBitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vertex Bit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF0F2B5B),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF0F2B5B),
          secondary: Color(0xFF2563EB),
          surface: Color(0xFFF8F9FA),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/contact': (context) => const ContactScreen(),
      },
    );
  }
}
