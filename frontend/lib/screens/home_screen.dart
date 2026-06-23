import 'package:flutter/material.dart';
import 'package:vertex_bit/widgets/about_section.dart';
import 'package:vertex_bit/widgets/products_section.dart';
import 'package:vertex_bit/widgets/services_section.dart';
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
  final _aboutKey = GlobalKey();
  final _productsKey = GlobalKey();
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
                  AboutSection(key: _aboutKey),
                  const _TrustSection(),
                  ServicesSection(key: _servicesKey),
                  ProductsSection(key: _productsKey),
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
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 900;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 31, 83, 195),
            Color(0xFF0F2B5B),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 70,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: isMobile
              ? Column(
                  children: [
                    _heroContent(context, true),
                    const SizedBox(height: 40),
                    _heroImage(),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: _heroContent(context, false),
                    ),
                    const SizedBox(width: 60),
                    Expanded(
                      flex: 4,
                      child: _heroImage(),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _heroContent(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          "Transforming Ideas into\nIntelligent Digital Solutions",
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: TextStyle(
            color: Colors.white,
            fontSize: isMobile ? 40 : 60,
            fontWeight: FontWeight.bold,
            height: 1.15,
          ),
        ),

        const SizedBox(height: 24),

        Text(
          "Vertex Bit helps startups and businesses build AI-powered "
          "applications, modern websites, mobile apps, dashboards and "
          "enterprise software that accelerate digital transformation.",
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: isMobile ? 18 : 22,
            height: 1.7,
          ),
        ),

        const SizedBox(height: 40),

        Wrap(
          spacing: 20,
          runSpacing: 15,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/contact");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 34,
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Get In Touch",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(
                  color: Colors.white,
                  width: 2,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 34,
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Our Services",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _heroImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Image.asset(
        "assets/images/hero_team.jpg",
        fit: BoxFit.cover,
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

class _TrustItem {
  final String title;
  final String description;

  const _TrustItem(this.title, this.description);
}

