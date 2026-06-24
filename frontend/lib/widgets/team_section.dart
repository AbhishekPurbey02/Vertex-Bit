import 'package:flutter/material.dart';
import '../utils/constants.dart';

class TeamSection extends StatefulWidget {
  const TeamSection({super.key});

  @override
  State<TeamSection> createState() => _TeamSectionState();
}

class _TeamSectionState extends State<TeamSection> {
  int _hoveredIndex = -1;
  int _selectedMember = -1;

  final List<TeamMember> teamMembers = [
    TeamMember(
      name: 'Er. Saroj Ojha',
      position: 'Chief Technology Officer',
      subtitle: '(CTO)',
      bio: 'Er. Saroj Ojha is the Chief Technology Officer at Vertex Bit with over 10 years of experience in software architecture and cloud solutions. He leads the technology strategy and innovation initiatives.',
      socialLinks: {
        'Facebook': 'https://facebook.com/sarojojha',
        'LinkedIn': 'https://linkedin.com/in/sarojojha',
        'Instagram': 'https://instagram.com/sarojojha',
      },
    ),
    TeamMember(
      name: 'Er. Chandra Prasad Acharya',
      position: 'Managing Director',
      subtitle: 'Senior Dotnet Developer',
      bio: 'Er. Chandra Prasad Acharya is the Managing Director and Senior Dotnet Developer at Vertex Bit. With 12+ years of experience, he specializes in enterprise applications and team leadership.',
      socialLinks: {
        'Facebook': 'https://facebook.com/chandraacharya',
        'LinkedIn': 'https://linkedin.com/in/chandraacharya',
        'Instagram': 'https://instagram.com/chandraacharya',
      },
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
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Column(
            children: [
              _buildHeader(isMobile),
              const SizedBox(height: 50),
              isMobile
                  ? Column(
                      children: teamMembers.asMap().entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: _buildTeamCard(
                            index: entry.key,
                            member: entry.value,
                            isMobile: true,
                          ),
                        );
                      }).toList(),
                    )
                  : Row(
                      children: teamMembers.asMap().entries.map((entry) {
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: entry.key == 0 ? 30 : 0,
                            ),
                            child: _buildTeamCard(
                              index: entry.key,
                              member: entry.value,
                              isMobile: false,
                            ),
                          ),
                        );
                      }).toList(),
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
          'Our Leadership Team',
          style: TextStyle(
            fontSize: isMobile ? 28 : 40,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          'Meet the experts driving innovation at Vertex Bit',
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

  Widget _buildTeamCard({
    required int index,
    required TeamMember member,
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
      child: GestureDetector(
        onTap: () => _showTeamDetails(context, member),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          transform: isHovered && !isMobile
              ? Matrix4.translationValues(0, -8, 0)
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Avatar
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary,
                        AppColors.primary.withOpacity(0.7),
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      member.name.split(' ').map((e) => e[0]).join(''),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Name
                Text(
                  member.name,
                  style: TextStyle(
                    fontSize: isMobile ? 20 : 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                // Position
                Text(
                  member.position,
                  style: TextStyle(
                    fontSize: isMobile ? 14 : 16,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                // Subtitle
                Text(
                  member.subtitle,
                  style: TextStyle(
                    fontSize: isMobile ? 13 : 14,
                    color: AppColors.textGray,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // Click to view details
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'View Profile',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward,
                        color: AppColors.primary,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showTeamDetails(BuildContext context, TeamMember member) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: 500,
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with close button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Expertise On',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  member.subtitle,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textGray,
                  ),
                ),
                const SizedBox(height: 24),
                
                // Social links
                const Text(
                  'Connect With Me',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 12),
                _buildSocialLinks(member.socialLinks),
                const SizedBox(height: 16),
                Text(
                  'Click the icons to visit social profiles',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textGray,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 16),
                
                // Bio
                Text(
                  member.bio,
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.textDark,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 20),
                
                // Member info
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        member.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        member.position,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textGray,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        member.subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.primary,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSocialLinks(Map<String, String> socialLinks) {
    final socialIcons = {
      'Facebook': Icons.facebook,
      // 'LinkedIn': Icons.linkedin,
      // 'Instagram': Icons.instagram,
    };

    return Row(
      children: socialLinks.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.only(right: 16),
          child: _SocialIconButton(
            icon: socialIcons[entry.key] ?? Icons.link,
            label: entry.key,
            url: entry.value,
          ),
        );
      }).toList(),
    );
  }
}

class _SocialIconButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;

  const _SocialIconButton({
    required this.icon,
    required this.label,
    required this.url,
  });

  @override
  State<_SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<_SocialIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          // Open URL
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Opening ${widget.label}...'),
              behavior: SnackBarBehavior.floating,
            ),
          );
          // You can use url_launcher package to open actual URLs
          // launchUrl(Uri.parse(widget.url));
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: _isHovered
                ? AppColors.primary
                : AppColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          ),
          child: Icon(
            widget.icon,
            color: _isHovered ? Colors.white : AppColors.primary,
            size: 24,
          ),
        ),
      ),
    );
  }
}

class TeamMember {
  final String name;
  final String position;
  final String subtitle;
  final String bio;
  final Map<String, String> socialLinks;

  TeamMember({
    required this.name,
    required this.position,
    required this.subtitle,
    required this.bio,
    required this.socialLinks,
  });
}