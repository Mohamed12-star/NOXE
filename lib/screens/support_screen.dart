import 'package:flutter/material.dart';

import '../l10n/locale_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/rtl_icons.dart';

/// "SUPPORT" screen — contact channels and the partnership request.
///
/// No real WhatsApp/Telegram/email links are wired up yet (that needs the
/// actual contact handles/URLs), so every tile just closes with a
/// "coming soon" snackbar.
class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  void _comingSoon(BuildContext context, String label) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(tr('comingSoon', {'label': label}))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  icon: Icon(backIconFor(context), size: 18),
                  color: AppColors.textDark,
                ),
                Expanded(
                  child: Text(
                    tr('support_title'),
                    textAlign: TextAlign.center,
                    style: AppTextStyles.screenTitle,
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 0, 10),
              child: Text(tr('support_contactUs'), style: AppTextStyles.leagueName.copyWith(fontSize: 15)),
            ),
            _SupportTile(
              icon: Icons.chat_bubble_outline_rounded,
              iconBg: const Color(0xFFDFF7E9),
              iconColor: const Color(0xFF22B573),
              title: tr('support_whatsapp'),
              subtitle: tr('support_whatsappSubtitle'),
              onTap: () => _comingSoon(context, tr('support_whatsapp')),
            ),
            _SupportTile(
              icon: Icons.send_rounded,
              iconBg: const Color(0xFFE3EEFD),
              iconColor: const Color(0xFF3B82F6),
              title: tr('support_telegram'),
              subtitle: tr('support_telegramSubtitle'),
              onTap: () => _comingSoon(context, tr('support_telegram')),
            ),
            _SupportTile(
              icon: Icons.mail_outline_rounded,
              iconBg: const Color(0xFFE3EEFD),
              iconColor: const Color(0xFF3B82F6),
              title: tr('support_email'),
              subtitle: tr('support_emailSubtitle'),
              onTap: () => _comingSoon(context, tr('support_email')),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 0, 10),
              child: Text(tr('support_becomePartner'), style: AppTextStyles.leagueName.copyWith(fontSize: 15)),
            ),
            _SupportTile(
              icon: Icons.handshake_outlined,
              iconBg: const Color(0xFFEDE7F6),
              iconColor: const Color(0xFF7E57C2),
              title: tr('support_partnerRequest'),
              subtitle: tr('support_partnerRequestSubtitle'),
              onTap: () => _comingSoon(context, tr('support_partnerRequest')),
            ),
          ],
        ),
      ),
    );
  }
}

class _SupportTile extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SupportTile({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFEDEDED))),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.categoryTitle.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: AppTextStyles.chip.copyWith(color: AppColors.textGrey)),
                ],
              ),
            ),
            Icon(Icons.north_east_rounded, color: iconColor, size: 18),
          ],
        ),
      ),
    );
  }
}
