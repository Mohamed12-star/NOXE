import 'package:flutter/material.dart';

import '../l10n/locale_controller.dart';
import '../theme/app_theme.dart';

/// The 4 sections reachable from the app's root bottom navigation.
enum MainTab { gratuit, codePromo, vip, annonces }

class _TabSpec {
  final String emoji;
  final String labelKey;
  final Color color;

  const _TabSpec({required this.emoji, required this.labelKey, required this.color});
}

const Map<MainTab, _TabSpec> _tabSpecs = {
  MainTab.gratuit: _TabSpec(
    emoji: '🎁',
    labelKey: 'nav_gratuit',
    color: AppColors.gratuitTab,
  ),
  MainTab.codePromo: _TabSpec(
    emoji: '🎟️',
    labelKey: 'nav_codePromo',
    color: AppColors.codePromoTab,
  ),
  MainTab.vip: _TabSpec(
    emoji: '👑',
    labelKey: 'nav_vip',
    color: AppColors.vipTab,
  ),
  MainTab.annonces: _TabSpec(
    emoji: '📣',
    labelKey: 'nav_annonces',
    color: AppColors.annoncesTab,
  ),
};

/// Root navigation bar of the app: GRATUIT / CODE PROMO / VIP.
class MainBottomNav extends StatelessWidget {
  final MainTab selectedTab;
  final ValueChanged<MainTab> onTabSelected;

  const MainBottomNav({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: cardDecoration(radius: 28),
        child: Row(
          children: MainTab.values.map((tab) {
            final spec = _tabSpecs[tab]!;
            final isActive = tab == selectedTab;
            return Expanded(
              child: GestureDetector(
                onTap: () => onTabSelected(tab),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: isActive
                        ? spec.color.withValues(alpha: 0.14)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(spec.emoji, style: const TextStyle(fontSize: 20)),
                      const SizedBox(height: 4),
                      Text(
                        tr(spec.labelKey),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.chip.copyWith(
                          color: isActive ? spec.color : AppColors.textGrey,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
