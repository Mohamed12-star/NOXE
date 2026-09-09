import 'package:flutter/material.dart';

import '../auth/auth_controller.dart';
import '../auth/user_role.dart';
import '../l10n/locale_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/rtl_icons.dart';
import 'support_screen.dart';

/// "Mon profil" screen, opened from the drawer — shows the signed-in
/// Google account and lets the user sign out.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  String _planLabel(UserRole role) {
    switch (role) {
      case UserRole.admin:
        return tr('profile_admin');
      case UserRole.vip:
        return tr('profile_planVip');
      case UserRole.free:
        return tr('profile_planFree');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: authController,
      builder: (context, _) {
        final user = authController.currentUser;
        final role = authController.role;
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
                        tr('profile_title'),
                        textAlign: TextAlign.center,
                        style: AppTextStyles.screenTitle,
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
                const SizedBox(height: 12),
                Center(
                  child: ClipOval(
                    child: user?.photoURL != null
                        ? Image.network(
                            user!.photoURL!,
                            width: 88,
                            height: 88,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: 88,
                            height: 88,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFFFF8A00), Color(0xFFFF3D57)],
                              ),
                            ),
                            child: Text(
                              (user?.displayName?.isNotEmpty ?? false)
                                  ? user!.displayName![0].toUpperCase()
                                  : 'N',
                              style: AppTextStyles.screenTitle.copyWith(
                                color: Colors.white,
                                fontSize: 36,
                              ),
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  user?.displayName ?? tr('profile_name'),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.screenTitle.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: cardDecoration(radius: 18),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_planLabel(role), style: AppTextStyles.leagueName.copyWith(fontSize: 15)),
                            const SizedBox(height: 4),
                            Text(
                              tr('profile_planDescription'),
                              style: AppTextStyles.chip.copyWith(
                                color: AppColors.textGrey,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).maybePop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text(tr('profile_viewVip')),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _InfoTile(
                  icon: Icons.workspace_premium_outlined,
                  iconBg: const Color(0xFFFFF3D6),
                  iconColor: const Color(0xFFFFA726),
                  title: tr('profile_subscription'),
                  value: _planLabel(role),
                ),
                _InfoTile(
                  icon: Icons.mail_outline_rounded,
                  iconBg: const Color(0xFFE3EEFD),
                  iconColor: const Color(0xFF3B82F6),
                  title: tr('profile_email'),
                  value: user?.email ?? tr('profile_emailPlaceholder'),
                ),
                _InfoTile(
                  icon: Icons.vpn_key_outlined,
                  iconBg: const Color(0xFFEFF6D9),
                  iconColor: const Color(0xFF9CCC3C),
                  title: tr('profile_loginMethod'),
                  value: 'Google',
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SupportScreen()),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Color(0xFFEDEDED))),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.chat_bubble_outline_rounded, color: AppColors.textDark, size: 20),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(tr('profile_helpCenter'), style: AppTextStyles.categoryTitle),
                        ),
                        Icon(chevronIconFor(context), color: AppColors.textGrey),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: authController.signOut,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 14),
                    child: Row(
                      children: [
                        const Icon(Icons.logout_rounded, color: AppColors.fail, size: 20),
                        const SizedBox(width: 14),
                        Text(
                          tr('profile_signOut'),
                          style: AppTextStyles.categoryTitle.copyWith(color: AppColors.fail),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                Text(value, style: AppTextStyles.chip.copyWith(color: AppColors.textGrey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
