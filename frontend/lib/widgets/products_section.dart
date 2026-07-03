import 'package:flutter/material.dart';
import '../utils/constants.dart';

class ProductsSection extends StatefulWidget {
  const ProductsSection({super.key});

  @override
  State<ProductsSection> createState() => _ProductsSectionState();
}

class _ProductsSectionState extends State<ProductsSection> {
  int _hoveredIndex = -1;

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
      color: AppColors.surface,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Column(
            children: [
              _buildHeader(isMobile),
              const SizedBox(height: 50),
              isMobile
                  ? Column(
                      children: [
                        _buildProductCard(
                          index: 0,
                          title: 'Vertexaccount',
                          subtitle: 'Cooperative Management System',
                          description:
                              'Complete cooperative management solution with accounting, member management, and reporting.',
                          price: 'Rs. 35000.00',
                          originalPrice: 'Rs. 40000.00',
                          isMobile: true,
                        ),
                        const SizedBox(height: 24),
                        _buildProductCard(
                          index: 1,
                          title: 'Vertex School Management',
                          subtitle: 'School Management Software',
                          description:
                              'Single system containing accounting, library, examination, and total school information system.',
                          price: 'Rs. 30000.00',
                          originalPrice: 'Rs. 40000.00',
                          isMobile: true,
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: _buildProductCard(
                            index: 0,
                            title: 'Vertexaccount',
                            subtitle: 'Cooperative Management System',
                            description:
                                'Complete cooperative management solution with accounting, member management, and reporting.',
                            price: 'Rs. 35000.00',
                            originalPrice: 'Rs. 40000.00',
                            isMobile: false,
                          ),
                        ),
                        const SizedBox(width: 30),
                        Expanded(
                          child: _buildProductCard(
                            index: 1,
                            title: 'Vertex School Management',
                            subtitle: 'School Management Software',
                            description:
                                'Single system containing accounting, library, examination, and total school information system.',
                            price: 'Rs. 30000.00',
                            originalPrice: 'Rs. 40000.00',
                            isMobile: false,
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isMobile) {
    return Column(
      children: [
        Text(
          'Our Innovative Products',
          style: TextStyle(
            fontSize: isMobile ? 28 : 40,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          'Discover our cutting-edge solutions designed to transform your business',
          style: TextStyle(
            fontSize: isMobile ? 14 : 18,
            color: AppColors.textGray,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Container(
          width: 80,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard({
    required int index,
    required String title,
    required String subtitle,
    required String description,
    required String price,
    required String originalPrice,
    required bool isMobile,
  }) {
    final isHovered = _hoveredIndex == index;

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _hoveredIndex = index;
        });
      },
      onExit: (_) {
        setState(() {
          _hoveredIndex = -1;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        transform: isHovered && !isMobile
            ? Matrix4.translationValues(
                0, -8, 0) // ✅ Correct: use translationValues
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isHovered
              ? [
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
            color: isHovered ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withOpacity(0.7),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  index == 0 ? Icons.account_balance : Icons.school,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: TextStyle(
                  fontSize: isMobile ? 22 : 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: isMobile ? 14 : 16,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: TextStyle(
                  fontSize: isMobile ? 14 : 15,
                  color: AppColors.textGray,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    originalPrice,
                    style: TextStyle(
                      fontSize: 18,
                      decoration: TextDecoration.lineThrough,
                      color: AppColors.textGray.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildBuyButton(isHovered),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBuyButton(bool isHovered) {
    return MouseRegion(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          gradient: isHovered
              ? LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withOpacity(0.8),
                  ],
                )
              : LinearGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.8),
                    AppColors.primary,
                  ],
                ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Product purchase feature coming soon!'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            borderRadius: BorderRadius.circular(10),
            child: Center(
              child: Text(
                'Buy Now',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
