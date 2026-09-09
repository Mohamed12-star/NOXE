import 'package:flutter/material.dart';

import '../l10n/locale_controller.dart';
import '../theme/app_theme.dart';

/// Placeholder notification center opened from the top bar's bell icon.
///
/// There is no push-notification backend wired up yet (that needs a service
/// like Firebase Cloud Messaging); this just shows the latest in-app
/// announcements locally so the entry point exists in the UI.
class _NotificationItem {
  final IconData icon;
  final String titleKey;
  final String subtitleKey;

  const _NotificationItem({
    required this.icon,
    required this.titleKey,
    required this.subtitleKey,
  });
}

const List<_NotificationItem> _mockNotifications = [
  _NotificationItem(
    icon: Icons.celebration_rounded,
    titleKey: 'notif1_title',
    subtitleKey: 'notif1_subtitle',
  ),
  _NotificationItem(
    icon: Icons.campaign_rounded,
    titleKey: 'notif2_title',
    subtitleKey: 'notif2_subtitle',
  ),
  _NotificationItem(
    icon: Icons.workspace_premium_rounded,
    titleKey: 'notif3_title',
    subtitleKey: 'notif3_subtitle',
  ),
];

Future<void> showNotificationsSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.cardBackground,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: AppColors.textGrey.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(tr('notifications_title'), style: AppTextStyles.screenTitle),
              const SizedBox(height: 16),
              for (final item in _mockNotifications) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(item.icon, color: AppColors.primary, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(tr(item.titleKey), style: AppTextStyles.leagueName),
                          const SizedBox(height: 2),
                          Text(
                            tr(item.subtitleKey),
                            style: AppTextStyles.chip.copyWith(
                              color: AppColors.textGrey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ],
          ),
        ),
      );
    },
  );
}
