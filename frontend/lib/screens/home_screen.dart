import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Column(
        children: [
          Navbar(
            selectedIndex: _currentIndex,
            onItemSelected: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Hero Section
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
                    child: Column(
                      children: [
                        const Text(
                          AppStrings.tagline,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -1,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          AppStrings.location,
                          style: const TextStyle(
                            fontSize: 18,
                            color: AppColors.electricBlue,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.electricBlue,
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('Get Started →', style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(width: 16),
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: AppColors.electricBlue),
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('Our Services'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  // Stats Section
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 48),
                    color: AppColors.darkGray,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStat('50+', 'Projects Done'),
                        _buildStat('30+', 'Happy Clients'),
                        _buildStat('4.9', 'Avg Rating'),
                      ],
                    ),
                  ),
                  
                  // Services Section
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
                    child: Column(
                      children: [
                        const Text(
                          'Our Premium Services',
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
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
                  
                  // Products Section
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
                    color: AppColors.darkGray,
                    child: Column(
                      children: [
                        const Text(
                          'Our Innovative Products',
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Discover our cutting-edge solutions designed to transform your business',
                          style: TextStyle(color: AppColors.gray),
                        ),
                        const SizedBox(height: 48),
                        Row(
                          children: [
                            Expanded(child: _buildProductCard('School Management System', 'Complete school ERP — attendance, exams, library, fees.')),
                            const SizedBox(width: 24),
                            Expanded(child: _buildProductCard('Cooperative Management', 'Full cooperative management with accounting and loans.')),
                            const SizedBox(width: 24),
                            Expanded(child: _buildProductCard('Clinic Management', 'Streamline patient records, appointments, and billing.')),
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
          style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppColors.electricBlue),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: AppColors.gray)),
      ],
    );
  }
  
  Widget _buildServiceCard(String title, String description) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.electricBlue.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.electricBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.code, color: AppColors.electricBlue, size: 28),
          ),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(description, style: const TextStyle(color: AppColors.gray, height: 1.5)),
        ],
      ),
    );
  }
  
  Widget _buildProductCard(String title, String description) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.electricBlue.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.business, color: AppColors.electricBlue, size: 40),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(description, style: const TextStyle(color: AppColors.gray, height: 1.4)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Rs. 25,000', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.electricBlue)),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.electricBlue,
                  foregroundColor: Colors.black,
                ),
                child: const Text('Buy Now'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}