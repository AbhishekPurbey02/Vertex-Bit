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
      color: Colors.white,
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
            Wrap(
              spacing: 24,
              runSpacing: 12,
              children: [
                for (final item in navItems)
                  _NavLink(
                    item: item,
                    isSelected: selectedIndex == item.index,
                    onTap: () => onItemSelected(item.index),
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
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: _Brand(),
            ),
            const Divider(height: 1),
            for (final item in navItems)
              ListTile(
                selected: selectedIndex == item.index,
                selectedColor: AppColors.primary,
                title: Text(item.title),
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
            color: AppColors.primary,
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
          AppStrings.companyName,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}

class _NavLink extends StatelessWidget {
  final NavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavLink({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: isSelected ? AppColors.primary : AppColors.textGray,
        padding: EdgeInsets.zero,
        minimumSize: const Size(44, 36),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        item.title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 14,
        ),
      ),
    );
  }
}
