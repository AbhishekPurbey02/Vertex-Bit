import 'package:flutter/material.dart';
import '../utils/constants.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: width < 700 ? 24 : 40,
        vertical: 48,
      ),
      color: AppColors.primary,
      child: const Column(
        children: [
          Wrap(
            spacing: 48,
            runSpacing: 32,
            alignment: WrapAlignment.spaceBetween,
            children: [
              _CompanyColumn(),
              _FooterColumn(
                title: 'Company',
                items: ['About Us', 'Portfolio', 'Reviews'],
              ),
              _FooterColumn(
                title: 'Services',
                items: [
                  'Web Development',
                  'Mobile Apps',
                  'Dashboards',
                  'API Integration'
                ],
              ),
              _FooterColumn(
                title: 'Contact',
                items: [AppStrings.email, AppStrings.phone, 'Nepal'],
              ),
            ],
          ),
          SizedBox(height: 32),
          Divider(color: Colors.white24),
          SizedBox(height: 16),
          Text(
            'Copyright 2026 Vertex Bit. All rights reserved.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _CompanyColumn extends StatelessWidget {
  const _CompanyColumn();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    'V',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                AppStrings.companyName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Practical digital solutions for websites, apps, dashboards and operations.',
            style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _FooterColumn extends StatelessWidget {
  final String title;
  final List<String> items;

  const _FooterColumn({
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8),
          for (final item in items) ...[
            Text(
              item,
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
            const SizedBox(height: 6),
          ],
        ],
      ),
    );
  }
}
