import 'package:flutter/material.dart';
import '../utils/constants.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 48),
      color: AppColors.darkGray,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Company Column
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    AppStrings.companyName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(AppStrings.tagline, style: const TextStyle(color: AppColors.gray, fontSize: 12)),
                ],
              ),
              
              // Quick Links
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Company', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('About Us', style: TextStyle(color: AppColors.gray)),
                  Text('Our Team', style: TextStyle(color: AppColors.gray)),
                  Text('Portfolio', style: TextStyle(color: AppColors.gray)),
                ],
              ),
              
              // Services
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Services', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('Web Development', style: TextStyle(color: AppColors.gray)),
                  Text('Mobile Apps', style: TextStyle(color: AppColors.gray)),
                  Text('UI/UX Design', style: TextStyle(color: AppColors.gray)),
                ],
              ),
              
              // Contact
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Contact', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('hello@vertexbit.com', style: TextStyle(color: AppColors.gray)),
                  Text('+977 98XXXXXXXX', style: TextStyle(color: AppColors.gray)),
                  Text('Biratnagar, Nepal', style: TextStyle(color: AppColors.gray)),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 32),
          const Divider(color: AppColors.gray),
          const SizedBox(height: 16),
          
          const Text(
            '© 2025 Vertex Bit. All rights reserved.',
            style: TextStyle(color: AppColors.gray, fontSize: 12),
          ),
        ],
      ),
    );
  }
}