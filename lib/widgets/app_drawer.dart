import 'package:flutter/material.dart';

import '../auth/auth_controller.dart';
import '../auth/user_role.dart';
import '../l10n/locale_controller.dart';
import '../screens/profile_screen.dart';
import '../theme/app_theme.dart';
import 'language_picker_sheet.dart';
import 'notifications_sheet.dart';
import 'rtl_icons.dart';

/// Side menu opened from the hamburger icon in the top bar.
///
/// [onGoHome] is called (after the drawer closes) to jump back to the
/// GRATUIT tab. Destinations without a real backend yet (site officiel,
/// confidentialité, EULA, Telegram) just close the drawer with a "coming
/// soon" snackbar — there's no CMS/auth to back them. "Langue" is fully
/// functional (see [showLanguagePicker]).
class AppDrawer extends StatelessWidget {
  final VoidCallback onGoHome;

  const AppDrawer({super.key, required this.onGoHome});

  String _planLabel(UserRole role) {
    switch (role) {
      case UserRole.admin:
        return tr('profile_admin');
      case UserRole.vip:
        return tr('profile_planVip');
      case UserRole.free:
        return tr('drawer_freeUser');
    }
  }

  void _comingSoon(BuildContext context, String label) {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(tr('comingSoon', {'label': label}))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.screenBackground,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          children: [
            Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFFF8A00), Color(0xFFFF3D57)],
                    ),
                  ),
                  child: Text(
                    'N',
                    style: AppTextStyles.screenTitle.copyWith(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('NOXE Pronos', style: AppTextStyles.leagueName.copyWith(fontSize: 16)),
                      const SizedBox(height: 3),
                      ListenableBuilder(
                        listenable: authController,
                        builder: (context, _) => Text(
                          _planLabel(authController.role),
                          style: AppTextStyles.chip.copyWith(color: AppColors.textGrey),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            _SectionTitle(tr('drawer_account')),
            _DrawerTile(
              icon: Icons.person_outline_rounded,
              iconBg: const Color(0xFFE3EEFD),
              iconColor: const Color(0xFF3B82F6),
              title: tr('drawer_myProfile'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                );
              },
            ),
            const SizedBox(height: 20),
            _SectionTitle(tr('drawer_preferences')),
            _DrawerTile(
              icon: Icons.language_rounded,
              iconBg: const Color(0xFFE3EEFD),
              iconColor: const Color(0xFF3B82F6),
              title: tr('drawer_language'),
              subtitle: '${appLocale.current.flag} ${appLocale.current.nativeName}',
              onTap: () => showLanguagePicker(context),
            ),
            const SizedBox(height: 20),
            _SectionTitle(tr('drawer_security')),
            _DrawerTile(
              icon: Icons.delete_outline_rounded,
              iconBg: const Color(0xFFFDE4E4),
              iconColor: const Color(0xFFE53935),
              title: tr('drawer_deleteAccount'),
              onTap: () => _comingSoon(context, tr('drawer_deleteAccount')),
            ),
            _DrawerTile(
              icon: Icons.notifications_none_rounded,
              iconBg: const Color(0xFFFFF3D6),
              iconColor: const Color(0xFFFFA726),
              title: tr('drawer_notifications'),
              onTap: () {
                Navigator.of(context).pop();
                showNotificationsSheet(context);
              },
            ),
            _DrawerTile(
              icon: Icons.verified_user_outlined,
              iconBg: const Color(0xFFEFF6D9),
              iconColor: const Color(0xFF9CCC3C),
              title: tr('drawer_privacy'),
              onTap: () => _comingSoon(context, tr('drawer_privacy')),
            ),
            _DrawerTile(
              icon: Icons.description_outlined,
              iconBg: const Color(0xFFE3EEFD),
              iconColor: const Color(0xFF3B82F6),
              title: tr('drawer_eula'),
              onTap: () => _comingSoon(context, tr('drawer_eula')),
            ),
            const SizedBox(height: 20),
            _SectionTitle(tr('drawer_links')),
            _DrawerTile(
              icon: Icons.groups_outlined,
              iconBg: const Color(0xFFE3EEFD),
              iconColor: const Color(0xFF3B82F6),
              title: tr('drawer_telegram'),
              onTap: () => _comingSoon(context, tr('drawer_telegram')),
            ),
            _DrawerTile(
              icon: Icons.info_outline_rounded,
              iconBg: const Color(0xFFF1F1F1),
              iconColor: AppColors.textDark,
              title: tr('drawer_about'),
              onTap: () {
                Navigator.of(context).pop();
                showAboutDialog(
                  context: context,
                  applicationName: 'NOXE Pronos',
                  applicationVersion: '1.0.0',
                );
              },
            ),
            const SizedBox(height: 12),
            _DrawerTile(
              icon: Icons.home_rounded,
              iconBg: const Color(0xFFDFF7E9),
              iconColor: const Color(0xFF22B573),
              title: tr('drawer_home'),
              subtitle: tr('drawer_homeSubtitle'),
              onTap: () {
                Navigator.of(context).pop();
                onGoHome();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String label;

  const _SectionTitle(this.label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 0, 10),
      child: Text(
        label,
        style: AppTextStyles.leagueName.copyWith(fontSize: 15),
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _DrawerTile({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    this.subtitle,
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
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(subtitle!, style: AppTextStyles.chip.copyWith(color: AppColors.textGrey)),
                  ],
                ],
              ),
            ),
            Icon(chevronIconFor(context), color: AppColors.textGrey),
          ],
        ),
      ),
    );
  }
}
