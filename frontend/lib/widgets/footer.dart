import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 48),
      color: const Color(0xFF0F2B5B),  // Dark blue background
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
                  Row(
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
                              color: Color(0xFF0F2B5B),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Vertex Bit',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(
                    width: 200,
                    child: Text(
                      'Transforming business through smart digital solutions.',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ),
                ],
              ),
              
              // Quick Links
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Company', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 8),
                  Text('About Us', style: TextStyle(color: Colors.white70, fontSize: 13)),
                  SizedBox(height: 6),
                  Text('Our Team', style: TextStyle(color: Colors.white70, fontSize: 13)),
                  SizedBox(height: 6),
                  Text('Portfolio', style: TextStyle(color: Colors.white70, fontSize: 13)),
                  SizedBox(height: 6),
                  Text('Reviews', style: TextStyle(color: Colors.white70, fontSize: 13)),
                ],
              ),
              
              // Services
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Services', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 8),
                  Text('Web Development', style: TextStyle(color: Colors.white70, fontSize: 13)),
                  SizedBox(height: 6),
                  Text('Mobile Apps', style: TextStyle(color: Colors.white70, fontSize: 13)),
                  SizedBox(height: 6),
                  Text('UI/UX Design', style: TextStyle(color: Colors.white70, fontSize: 13)),
                  SizedBox(height: 6),
                  Text('SaaS Products', style: TextStyle(color: Colors.white70, fontSize: 13)),
                ],
              ),
              
              // Contact
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Contact', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 8),
                  Text('hello@vertexbit.com', style: TextStyle(color: Colors.white70, fontSize: 13)),
                  SizedBox(height: 6),
                  Text('+977 98XXXXXXXX', style: TextStyle(color: Colors.white70, fontSize: 13)),
                  SizedBox(height: 6),
                  Text('Biratnagar, Nepal', style: TextStyle(color: Colors.white70, fontSize: 13)),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 32),
          const Divider(color: Colors.white24),
          const SizedBox(height: 16),
          
          const Text(
            '© 2025 Vertex Bit. All rights reserved.',
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),
        ],
      ),
    );
  }
}