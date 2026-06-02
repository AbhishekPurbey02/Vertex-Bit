import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import 'contact_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _onItemSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
    
    // Navigate to contact screen when Contact is clicked
    if (index == 4) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ContactScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  // Hero Section
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
                    color: Colors.white,
                    child: Column(
                      children: [
                        const Text(
                          'Your vision is brought to life\nwith precision and excellence.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A1A),
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Based in Nepal — Serving Globally',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF666666),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const ContactScreen()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0F2B5B),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('Get in Touch →', style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(width: 16),
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Color(0xFF0F2B5B)),
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('Our Services', style: TextStyle(color: Color(0xFF0F2B5B))),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  // Stats Section
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 48),
                    color: const Color(0xFFF8F9FA),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStat('10+', 'Completed Projects'),
                        _buildStat('100+', 'Happy Clients'),
                        _buildStat('15+', 'Years of Excellence'),
                      ],
                    ),
                  ),
                  
                  // Services Section
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
                    color: Colors.white,
                    child: Column(
                      children: [
                        const Text(
                          'Our Premium Services',
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A)),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Discover our cutting-edge solutions designed to transform your business',
                          style: TextStyle(color: Color(0xFF666666), fontSize: 16),
                        ),
                        const SizedBox(height: 48),
                        Row(
                          children: [
                            Expanded(child: _buildServiceCard('Web Development', 'Modern, responsive websites built with latest frameworks.')),
                            const SizedBox(width: 24),
                            Expanded(child: _buildServiceCard('Mobile App Development', 'Cross-platform apps with Flutter. Beautiful on iOS and Android.')),
                            const SizedBox(width: 24),
                            Expanded(child: _buildServiceCard('UI/UX Design', 'User-centered design that converts. Intuitive and stunning.')),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(child: _buildServiceCard('Hosting Services', 'Reliable, secure cloud hosting with maximum uptime.')),
                            const SizedBox(width: 24),
                            Expanded(child: _buildServiceCard('SaaS Development', 'Scalable subscription-based software solutions.')),
                            const SizedBox(width: 24),
                            Expanded(child: _buildServiceCard('API Integration', 'Connect your systems with custom APIs.')),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Color(0xFF0F2B5B)),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Color(0xFF666666), fontSize: 14)),
      ],
    );
  }
  
  Widget _buildServiceCard(String title, String description) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF0F2B5B).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.code, color: Color(0xFF0F2B5B), size: 28),
          ),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A))),
          const SizedBox(height: 8),
          Text(description, style: const TextStyle(color: Color(0xFF666666), height: 1.5)),
        ],
      ),
    );
  }
}