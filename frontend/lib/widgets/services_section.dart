import 'package:flutter/material.dart';
import '../utils/constants.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  static const services = [
    _ServiceItem(
      Icons.web,
      'Web Development',
      'Responsive websites and web apps built for performance and maintainability.',
    ),
    _ServiceItem(
      Icons.phone_iphone,
      'Mobile App Development',
      'Cross-platform Flutter applications with polished user experiences.',
    ),
    _ServiceItem(
      Icons.dashboard_customize,
      'Dashboard Development',
      'Internal tools, reporting views, and admin systems for daily operations.',
    ),
    _ServiceItem(
      Icons.storage,
      'Data Solutions',
      'Structured workflows for analytics, databases and business reporting.',
    ),
    _ServiceItem(
      Icons.cloud_queue,
      'Cloud Deployment',
      'Practical deployment setup for modern frontend, backend and database stacks.',
    ),
    _ServiceItem(
      Icons.integration_instructions,
      'UI/UX Design',
      'We design seamless digital experiences through research, rapid prototyping, and usability testing. Our goal is to deliver interfaces that are as functional as they are visually stunning.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final columns = width >= 1000
        ? 3
        : width >= 680
            ? 2
            : 1;
    final cardWidth = width < 680 ? double.infinity : (width - 104) / columns;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: width < 700 ? 24 : 40,
        vertical: 60,
      ),
      color: Colors.white,
      child: Column(
        children: [
          const Text(
            'Our Services',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Focused digital solutions for companies that need reliable software delivery.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textGray, fontSize: 16),
          ),
          const SizedBox(height: 42),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: [
              for (final service in services)
                SizedBox(
                  width: cardWidth,
                  child: _ServiceCard(service: service),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final _ServiceItem service;

  const _ServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 198),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(service.icon, color: AppColors.primary, size: 28),
          ),
          const SizedBox(height: 16),
          Text(
            service.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            service.description,
            style: const TextStyle(color: AppColors.textGray, height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _ServiceItem {
  final IconData icon;
  final String title;
  final String description;

  const _ServiceItem(this.icon, this.title, this.description);
}