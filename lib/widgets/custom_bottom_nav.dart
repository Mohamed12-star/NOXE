import 'package:flutter/material.dart';

import '../l10n/locale_controller.dart';
import '../theme/app_theme.dart';

/// Which list the [MatchListScreen] is currently displaying.
enum MatchListTab { recent, historique }

/// Two pill-shaped tabs ("RÉCENT" / "HISTORIQUE") pinned at the bottom of a
/// match list screen. The active tab is rendered with full opacity/elevation.
class CustomBottomNav extends StatelessWidget {
  final MatchListTab selectedTab;
  final ValueChanged<MatchListTab> onTabSelected;

  const CustomBottomNav({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: Row(
          children: [
            Expanded(
              child: _NavPill(
                label: tr('tab_recent'),
                icon: Icons.calendar_month_rounded,
                color: AppColors.recentTab,
                isActive: selectedTab == MatchListTab.recent,
                onTap: () => onTabSelected(MatchListTab.recent),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _NavPill(
                label: tr('tab_historique'),
                icon: Icons.history_rounded,
                color: AppColors.historiqueTab,
                isActive: selectedTab == MatchListTab.historique,
                onTap: () => onTabSelected(MatchListTab.historique),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavPill extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool isActive;
  final VoidCallback onTap;

  const _NavPill({
    required this.label,
    required this.icon,
    required this.color,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isActive ? color : color.withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(30),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: color.withValues(alpha: 0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: AppColors.textDark),
            const SizedBox(width: 8),
            Text(label, style: AppTextStyles.bottomNav),
          ],
        ),
      ),
    );
  }
}
