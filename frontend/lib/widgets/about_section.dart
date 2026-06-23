import 'package:flutter/material.dart';
import '../utils/constants.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < 900;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 60,
      ),
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: isMobile
              ? Column(
                  children: [
                    _buildContent(context, isMobile),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 6,
                      child: _buildContent(context, isMobile),
                    ),
                    const SizedBox(width: 40),
                    Expanded(
                      flex: 4,
                      child: _buildImage(),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About Vertex Bit',
          style: TextStyle(
            fontSize: isMobile ? 32 : 40,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Vertex Bit is a premier software company based in Nepal, dedicated to delivering cutting-edge technology solutions that empower businesses to thrive in the digital age.',
          style: TextStyle(
            fontSize: isMobile ? 16 : 18,
            color: AppColors.textDark,
            height: 1.8,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Our team of experienced developers, designers, and IT experts specializes in creating custom software solutions tailored to your specific business needs. We are committed to quality, innovation, and customer satisfaction, ensuring your vision is brought to life with precision and excellence.',
          style: TextStyle(
            fontSize: isMobile ? 16 : 18,
            color: AppColors.textGray,
            height: 1.8,
          ),
        ),
        const SizedBox(height: 30),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/about');
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Learn More →',
                style: TextStyle(
                  fontSize: isMobile ? 16 : 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 300,
        width: double.infinity,
        color: AppColors.primary.withOpacity(0.1),
        child: Center(
          child: Icon(
            Icons.business_center,
            size: 80,
            color: AppColors.primary.withOpacity(0.5),
          ),
        ),
        // Or use an actual image:
        // child: Image.asset(
        //   "assets/images/about_image.jpg",
        //   fit: BoxFit.cover,
        // ),
      ),
    );
  }
}