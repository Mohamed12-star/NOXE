import 'package:flutter/material.dart';

import '../l10n/locale_controller.dart';
import '../theme/app_theme.dart';

/// A blurred/masked match card teasing content reserved to the Pro plan.
///
/// Shows faint placeholder bars standing in for the hidden match info, an
/// overlay message, and a call-to-action button.
class ProLockedCard extends StatelessWidget {
  final String categoryTitle;
  final VoidCallback? onUnlockTap;

  const ProLockedCard({
    super.key,
    required this.categoryTitle,
    this.onUnlockTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 190,
      decoration: cardDecoration(radius: 20),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Opacity(
              opacity: 0.35,
              child: Column(
                children: [
                  Row(
                    children: [
                      _placeholderBar(width: 90, height: 12),
                      const Spacer(),
                      _placeholderBar(width: 40, height: 18, color: AppColors.success),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      CircleAvatar(radius: 20, backgroundColor: Color(0xFFE0E0E0)),
                      CircleAvatar(radius: 20, backgroundColor: Color(0xFFE0E0E0)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _placeholderBar(width: double.infinity, height: 30),
                ],
              ),
            ),
          ),
          Container(color: Colors.white.withValues(alpha: 0.55)),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.lock_rounded, color: AppColors.textGrey, size: 22),
              const SizedBox(height: 8),
              Text(
                tr('locked_title'),
                style: AppTextStyles.leagueName.copyWith(fontSize: 15),
              ),
              const SizedBox(height: 4),
              Text(
                tr('locked_subtitle', {'category': categoryTitle}),
                style: AppTextStyles.chip.copyWith(color: AppColors.textGrey),
              ),
              const SizedBox(height: 14),
              ElevatedButton(
                onPressed: onUnlockTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  tr('locked_cta'),
                  style: AppTextStyles.bottomNav.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _placeholderBar({
    required double width,
    required double height,
    Color color = const Color(0xFFE0E0E0),
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
