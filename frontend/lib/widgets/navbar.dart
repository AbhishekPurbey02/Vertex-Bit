import 'package:flutter/material.dart';
import '../utils/constants.dart';

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
      decoration: const BoxDecoration(
        color: AppColors.black,
        border: Border(
          bottom: BorderSide(color: AppColors.electricBlue, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.electricBlue,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    'V',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                AppStrings.companyName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
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
    return GestureDetector(
      onTap: () => onItemSelected(index),
      child: Text(
        title,
        style: TextStyle(
          color: selectedIndex == index ? AppColors.electricBlue : Colors.white,
          fontWeight: selectedIndex == index ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}