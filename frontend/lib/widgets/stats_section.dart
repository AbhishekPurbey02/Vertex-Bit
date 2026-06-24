import 'package:flutter/material.dart';
import '../utils/constants.dart';

class StatsSection extends StatefulWidget {
  const StatsSection({super.key});

  @override
  State<StatsSection> createState() => _StatsSectionState();
}

class _StatsSectionState extends State<StatsSection> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 700;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 60,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.primary.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: isMobile
              ? Column(
                  children: [
                    _buildStatCard(
                      icon: Icons.check_circle_outline,
                      number: '10+',
                      label: 'Completed Projects',
                      isMobile: true,
                    ),
                    const SizedBox(height: 30),
                    _buildStatCard(
                      icon: Icons.people_outline,
                      number: '100+',
                      label: 'Happy Clients',
                      isMobile: true,
                    ),
                    const SizedBox(height: 30),
                    _buildStatCard(
                      icon: Icons.star_outline,
                      number: '15+',
                      label: 'Years of Excellence',
                      isMobile: true,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatCard(
                      icon: Icons.check_circle_outline,
                      number: '10+',
                      label: 'Completed Projects',
                      isMobile: false,
                    ),
                    _buildStatCard(
                      icon: Icons.people_outline,
                      number: '100+',
                      label: 'Happy Clients',
                      isMobile: false,
                    ),
                    _buildStatCard(
                      icon: Icons.star_outline,
                      number: '15+',
                      label: 'Years of Excellence',
                      isMobile: false,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String number,
    required String label,
    required bool isMobile,
  }) {
    return Container(
      width: isMobile ? double.infinity : 300,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            number,
            style: TextStyle(
              fontSize: isMobile ? 36 : 42,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: isMobile ? 14 : 16,
              color: Colors.white.withOpacity(0.9),
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}