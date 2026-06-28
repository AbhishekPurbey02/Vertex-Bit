import 'package:flutter/material.dart';
import '../utils/constants.dart';

class FaqSection extends StatefulWidget {
  const FaqSection({super.key});

  @override
  State<FaqSection> createState() => _FaqSectionState();
}

class _FaqSectionState extends State<FaqSection> {
  int _expandedIndex = -1;

  final List<FaqItem> faqItems = [
    FaqItem(
      question: 'What technologies does Vertex Bit primarily use for software development?',
      answer: 'We mainly use Flutter,Flask,Sql lite,Postgres SQL, Python (Django), and .NET Core for our development projects, depending on client needs and project requirements. Our team chooses the best technology stack that fits your specific project requirements.',
    ),
    FaqItem(
      question: 'Does Vertex Bit offer multi-platform development?',
      answer: 'Yes, we specialize in cross-platform development using Flutter and React Native for mobile apps, and we build responsive web applications that work seamlessly across all devices and browsers.',
    ),
    FaqItem(
      question: 'What design and multimedia services does Vertex Bit provide?',
      answer: 'We offer comprehensive design services including UI/UX design, graphic design, branding, logo design, and video editing. Our creative team ensures your brand stands out with professional visuals and engaging multimedia content.',
    ),
    FaqItem(
      question: 'Does Vertex Bit work on AI and innovative projects?',
      answer: 'Absolutely! We specialize in AI-powered applications, machine learning solutions and innovative digital products. Our team stays at the forefront of technology to deliver cutting-edge solutions for our clients.',
    ),
    FaqItem(
      question: 'What products has Vertex Bit recently developed?',
      answer: 'We have recently developed cooperative management software (Lunaccount), school management systems, ride-sharing platforms, and various custom enterprise solutions for businesses across different industries.',
    ),
    FaqItem(
      question: 'Can Vertex Bit build customized software based on client requirements?',
      answer: 'Yes, we specialize in custom software development tailored to your specific business needs. From initial discovery to final delivery, we work closely with you to build solutions that solve your unique challenges.',
    ),
  ];

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
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // Header
              _buildHeader(isMobile),
              const SizedBox(height: 50),
              // FAQ List
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: faqItems.length,
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                ),
                itemBuilder: (context, index) {
                  return _buildFaqItem(
                    index: index,
                    item: faqItems[index],
                    isMobile: isMobile,
                  );
                },
              ),
              const SizedBox(height: 40),
              
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
          'Frequently Asked Questions',
          style: TextStyle(
            fontSize: isMobile ? 28 : 40,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          'Get quick answers to common queries',
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

  Widget _buildFaqItem({
    required int index,
    required FaqItem item,
    required bool isMobile,
  }) {
    final isExpanded = _expandedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _expandedIndex = isExpanded ? -1 : index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: isMobile ? 0 : 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    item.question,
                    style: TextStyle(
                      fontSize: isMobile ? 15 : 17,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                      height: 1.4,
                    ),
                  ),
                ),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: isExpanded
                        ? AppColors.primary
                        : AppColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      isExpanded ? Icons.remove : Icons.add,
                      color: isExpanded ? Colors.white : AppColors.primary,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            if (isExpanded) ...[
              const SizedBox(height: 16),
              Text(
                item.answer,
                style: TextStyle(
                  fontSize: isMobile ? 14 : 16,
                  color: AppColors.textGray,
                  height: 1.8,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class FaqItem {
  final String question;
  final String answer;

  FaqItem({
    required this.question,
    required this.answer,
  });
}