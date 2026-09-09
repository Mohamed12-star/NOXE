import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'rtl_icons.dart';

/// A single tappable option row on the main menu screen.
///
/// Rounded, elevated card with a colored leading icon, an uppercase bold
/// title, and a trailing chevron.
class MenuCategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onTap;

  const MenuCategoryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: cardDecoration(),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(title, style: AppTextStyles.categoryTitle),
              ),
              Icon(
                chevronIconFor(context),
                color: AppColors.textGrey.withValues(alpha: 0.6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
