import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/footer.dart';
import '../widgets/navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _servicesKey = GlobalKey();
  int _currentIndex = 0;

  void _onItemSelected(int index) {
    setState(() => _currentIndex = index);

    if (index == 0) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
      return;
    }

    if (index == 2) {
      final targetContext = _servicesKey.currentContext;
      if (targetContext != null) {
        Scrollable.ensureVisible(
          targetContext,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOut,
        );
      }
      return;
    }

    if (index == 4) {
      Navigator.pushNamed(context, '/contact');
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('${navItems[index].title} page is coming in the next phase.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: NavDrawer(
        selectedIndex: _currentIndex,
        onItemSelected: _onItemSelected,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Navbar(
            selectedIndex: _currentIndex,
            onItemSelected: _onItemSelected,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const _HeroSection(),
                  const _TrustSection(),
                  _ServicesSection(key: _servicesKey),
                  const Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 700;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 40,
        vertical: isMobile ? 56 : 80,
      ),
      color: Colors.white,
      child: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 920),
            child: Text(
              AppStrings.tagline,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 34 : 48,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
                height: 1.18,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            AppStrings.location,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: AppColors.textGray),
          ),
          const SizedBox(height: 32),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            runSpacing: 12,
            children: [
              ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/contact'),
                icon: const Icon(Icons.mail_outline),
                label: const Text('Get in Touch'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  final state =
                      context.findAncestorStateOfType<_HomeScreenState>();
                  state?._onItemSelected(2);
                },
                icon: const Icon(Icons.design_services_outlined),
                label: const Text('Our Services'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TrustSection extends StatelessWidget {
  const _TrustSection();

  static const items = [
    _TrustItem('Client-first', 'Discovery before delivery'),
    _TrustItem('Maintainable', 'Clean architecture and handoff'),
    _TrustItem('Responsive', 'Built for desktop, tablet, and mobile'),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: width < 700 ? 24 : 40,
        vertical: 42,
      ),
      color: AppColors.surface,
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 24,
        runSpacing: 18,
        children: [
          for (final item in items)
            SizedBox(
              width: width < 700 ? double.infinity : 260,
              child: Column(
                children: [
                  Text( 
                    item.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: AppColors.textGray, fontSize: 14),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _ServicesSection extends StatelessWidget {
  const _ServicesSection({super.key});

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
      'Structured workflows for analytics, databases, and business reporting.',
    ),
    _ServiceItem(
      Icons.cloud_queue,
      'Cloud Deployment',
      'Practical deployment setup for modern frontend, backend, and database stacks.',
    ),
    _ServiceItem(
      Icons.integration_instructions,
      'API Integration',
      'Connect websites, apps, and business tools through clean API contracts.',
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

class _TrustItem {
  final String title;
  final String description;

  const _TrustItem(this.title, this.description);
}

class _ServiceItem {
  final IconData icon;
  final String title;
  final String description;

  const _ServiceItem(this.icon, this.title, this.description);
}
