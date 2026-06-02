import 'package:flutter/material.dart';
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
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        // fontFamily: 'Poppins',
        colorScheme: const ColorScheme.dark(
          primary: Colors.black,
          secondary: Color(0xFF00D4FF), // Electric Blue
          surface: Color(0xFF0A0A0A),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}