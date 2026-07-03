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
      'We design seamless digital experiences through research, rapid prototyping and usability testing. Our goal is to deliver interfaces that are as functional as they are visually stunning.',
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

// ⭐ UPDATED: Service Card with hover effect (like Products section)
class _ServiceCard extends StatefulWidget {
  final _ServiceItem service;

  const _ServiceCard({required this.service});

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

// ⭐ NEW: State for Service Card with hover animation
class _ServiceCardState extends State<_ServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        // ⭐ Lift up on hover (like Products section)
        transform: _isHovered
            ? Matrix4.translationValues(0, -8, 0) // Lift up by 8px
            : Matrix4.identity(),
        child: Container(
          constraints: const BoxConstraints(minHeight: 198),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: _isHovered
                ? [
                    // ⭐ Enhanced shadow on hover (like Products section)
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.2),
                      blurRadius: 20,
                      spreadRadius: 5,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
            border: Border.all(
              color: _isHovered ? AppColors.primary : Colors.black.withOpacity(0.08),
              width: _isHovered ? 2 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ⭐ Icon container with hover effect
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _isHovered
                      ? AppColors.primary.withOpacity(0.15)
                      : AppColors.primary.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  widget.service.icon,
                  color: _isHovered ? AppColors.primary : AppColors.primary,
                  size: 28,
                ),
              ),
              const SizedBox(height: 16),
              // ⭐ Title with hover effect
              Text(
                widget.service.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 8),
              // ⭐ Description with hover effect
              Text(
                widget.service.description,
                style: TextStyle(
                  color: AppColors.textGray,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
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