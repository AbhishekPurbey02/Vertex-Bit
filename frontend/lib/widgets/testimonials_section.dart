import 'package:flutter/material.dart';
import '../utils/constants.dart';

class TestimonialsSection extends StatefulWidget {
  const TestimonialsSection({super.key});

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final List<Testimonial> testimonials = [
    Testimonial(
      quote: 'Safari Yatri Private Limited is highly satisfied with the application and IT services provided by Vertex Bit. Their team delivered a reliable, user-friendly ride-sharing platform tailored to our needs, with excellent support and professionalism. We confidently recommend them as a trusted IT partner.',
      clientName: 'Mousam Tamang',
      clientPosition: 'CEO, Safari Yatri Private Limited',
      company: 'Safari Yatri',
    ),
    // Add more testimonials here
    // Testimonial(
    //   quote: 'Another great testimonial from a happy client...',
    //   clientName: 'Client Name',
    //   clientPosition: 'Position, Company',
    //   company: 'Company Name',
    // ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // Header
              _buildHeader(isMobile),
              const SizedBox(height: 50),
              
              // Testimonial Card
              Container(
                padding: EdgeInsets.all(isMobile ? 24 : 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.black.withOpacity(0.05),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    // Quote icon
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.format_quote,
                        color: AppColors.primary,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Testimonial text
                    SizedBox(
                      height: isMobile ? 200 : 120,
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        children: testimonials.map((testimonial) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Center(
                              child: Text(
                                '"${testimonial.quote}"',
                                style: TextStyle(
                                  fontSize: isMobile ? 16 : 18,
                                  color: AppColors.textDark,
                                  height: 1.8,
                                  fontStyle: FontStyle.italic,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Client info
                    Column(
                      children: [
                        Text(
                          testimonials[_currentIndex].clientName,
                          style: TextStyle(
                            fontSize: isMobile ? 18 : 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          testimonials[_currentIndex].clientPosition,
                          style: TextStyle(
                            fontSize: isMobile ? 14 : 16,
                            color: AppColors.textGray,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 30),
                    
                    // Dot indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        testimonials.length,
                        (index) => GestureDetector(
                          onTap: () {
                            _pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentIndex == index
                                  ? AppColors.primary
                                  : AppColors.textGray.withOpacity(0.3),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
          'What Our Clients Say',
          style: TextStyle(
            fontSize: isMobile ? 28 : 40,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          'Trusted by businesses worldwide',
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
}

class Testimonial {
  final String quote;
  final String clientName;
  final String clientPosition;
  final String company;

  Testimonial({
    required this.quote,
    required this.clientName,
    required this.clientPosition,
    required this.company,
  });
}