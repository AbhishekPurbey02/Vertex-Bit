import 'package:flutter/material.dart';
import '../utils/constants.dart';

class NavItem {
  final String title;
  final int index;

  const NavItem(this.title, this.index);
}

const List<NavItem> navItems = [
  NavItem('Home', 0),
  NavItem('About', 1),
  NavItem('Services', 2),
  NavItem('Products', 3),
  NavItem('Contact', 4),
  NavItem('FAQ', 5),
  NavItem('Login', 6),
];

class Navbar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const Navbar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isCompact = width < 860;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width < 600 ? 20 : 40,
        vertical: 14,
      ),
      color: Colors.white, // White background
      child: Row(
        children: [
          const _Brand(),
          const Spacer(),
          if (isCompact)
            Builder(
              builder: (context) => IconButton(
                tooltip: 'Open navigation',
                icon: const Icon(Icons.menu, color: AppColors.textDark),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              ),
            )
          else
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final item in navItems)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: _NavLink(
                      item: item,
                      isSelected: selectedIndex == item.index,
                      onTap: () => onItemSelected(item.index),
                    ),
                  ),
                const SizedBox(width: 18),
                ElevatedButton(
                  onPressed: () {
                    onItemSelected(6);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 26,
                      vertical: 18,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const NavDrawer({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primary,
      child: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: _Brand(),
            ),
            const Divider(height: 1, color: Colors.white54),
            for (final item in navItems)
              ListTile(
                selected: selectedIndex == item.index,
                selectedColor: Colors.white,
                title: Text(
                  item.title,
                  style: const TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  onItemSelected(item.index);
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: const BoxDecoration(
            color: AppColors.primary, // Dark blue/teal circle
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Text(
              'V',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          'Vertex Bit', // Changed to match your brand name
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark, // DARK text for light background
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}

class _NavLink extends StatefulWidget {
  final NavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavLink({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    final active = hovering || widget.isSelected;

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          hovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          hovering = false;
        });
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.item.title,
              style: TextStyle(
                color: AppColors.textDark, // DARK text for light background
                fontWeight: active ? FontWeight.bold : FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              width: active ? 42 : 0,
              height: 3,
              decoration: BoxDecoration(
                color: AppColors.primary, // DARK underline for light background
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}