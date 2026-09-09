import 'package:flutter/material.dart';

import '../l10n/locale_controller.dart';
import '../models/match_model.dart';
import '../theme/app_theme.dart';
import '../widgets/app_drawer.dart';
import '../widgets/main_bottom_nav.dart';
import '../widgets/notifications_sheet.dart';
import 'announcements_screen.dart';
import 'code_promo_screen.dart';
import 'main_menu_screen.dart';

/// App root: hosts the 4-tab bottom navigation (GRATUIT / CODE PROMO / VIP /
/// ANNONCES).
///
/// GRATUIT and VIP both show the categories menu, but VIP includes the
/// exclusive "DÉFI MONTANT" category; CODE PROMO is an empty placeholder
/// until its content is designed; ANNONCES is the community feed where users
/// publish posts that others can reply to and react to.
class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  MainTab _selectedTab = MainTab.gratuit;

  static const List<MainTab> _tabOrder = MainTab.values;

  // Deliberately NOT const: these widgets must be rebuilt (not reused as
  // identical instances) whenever RootScreen rebuilds — e.g. on a language
  // change — otherwise Flutter's element diffing sees `oldWidget == newWidget`
  // and skips rebuilding their subtree entirely, leaving stale translated
  // text on screen until something else (a tab switch, a hot restart)
  // happens to touch them. Their State (scroll position, repository data,
  // etc.) is still preserved across these rebuilds since type+key match.
  List<Widget> _tabBodies() => [
        MainMenuScreen(key: const ValueKey('gratuit'), categories: mockGratuitCategories),
        CodePromoScreen(),
        MainMenuScreen(key: const ValueKey('vip'), categories: mockVipCategories),
        AnnouncementsScreen(),
      ];

  @override
  Widget build(BuildContext context) {
    // Subscribes directly to the language controller instead of relying on
    // an ancestor rebuild to reach this State — a pushed/cached route or a
    // Scaffold-managed overlay (like the drawer) won't reliably propagate
    // one, which is exactly why a language change used to need a manual
    // page refresh to show up.
    return ListenableBuilder(
      listenable: appLocale,
      builder: (context, _) {
        return Scaffold(
          drawer: AppDrawer(onGoHome: () => setState(() => _selectedTab = MainTab.gratuit)),
          body: Column(
            children: [
              const _TopBar(),
              Expanded(
                child: IndexedStack(
                  index: _tabOrder.indexOf(_selectedTab),
                  children: _tabBodies(),
                ),
              ),
            ],
          ),
          bottomNavigationBar: MainBottomNav(
            selectedTab: _selectedTab,
            onTabSelected: (tab) => setState(() => _selectedTab = tab),
          ),
        );
      },
    );
  }
}

/// Persistent header with the hamburger menu (opens [AppDrawer]) and a
/// notifications entry point.
class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        color: AppColors.screenBackground,
        child: Row(
          children: [
            IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.menu_rounded),
              color: AppColors.textDark,
            ),
            const Spacer(),
            IconButton(
              onPressed: () => showNotificationsSheet(context),
              icon: Badge(
                backgroundColor: AppColors.fail,
                smallSize: 9,
                child: const Icon(Icons.notifications_none_rounded),
              ),
              color: AppColors.textDark,
            ),
          ],
        ),
      ),
    );
  }
}
