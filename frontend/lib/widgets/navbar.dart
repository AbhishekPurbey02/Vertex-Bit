import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;
  
  const Navbar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF0F2B5B),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    'V',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Vertex Bit',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          
          // Nav Links
          Row(
            children: [
              _buildNavLink('Home', 0),
              const SizedBox(width: 24),
              _buildNavLink('About', 1),
              const SizedBox(width: 24),
              _buildNavLink('Services', 2),
              const SizedBox(width: 24),
              _buildNavLink('Products', 3),
              const SizedBox(width: 24),
              _buildNavLink('Contact', 4),
              const SizedBox(width: 24),
              _buildNavLink('FAQ', 5),
              const SizedBox(width: 24),
              _buildNavLink('Login', 6),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildNavLink(String title, int index) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onItemSelected(index),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? const Color(0xFF0F2B5B) : const Color(0xFF666666),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 14,
        ),
      ),
    );
  }
}