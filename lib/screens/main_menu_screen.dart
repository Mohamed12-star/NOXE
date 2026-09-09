import 'package:flutter/material.dart';

import '../models/match_model.dart';
import '../theme/app_theme.dart';
import '../widgets/menu_category_card.dart';
import 'match_list_screen.dart';
import 'montant_challenge_screen.dart';

/// The home screen: a scrollable list of pronostics categories.
class MainMenuScreen extends StatelessWidget {
  final List<MenuCategoryItem> categories;

  const MainMenuScreen({super.key, required this.categories});

  /// Builds the [MatchListScreen] configuration for a given category.
  ///
  /// "RÉCENT" always shows the newest published predictions (not yet
  /// played/resolved); "HISTORIQUE" always shows past matches with their
  /// results. VIP categories reuse the same data as their GRATUIT
  /// counterpart — only the "VIP" suffix in [title] differs — so the suffix
  /// is stripped before matching.
  ///
  /// "PRONOS RECOMMANDÉS" and "MATCH SIMPLE" reuse the exact data sets shown
  /// in the design; every other category falls back to a generic demo data
  /// set.
  MatchListScreen _screenFor(String title) {
    final displayTitle = categoryDisplayTitle(title);
    switch (_baseTitle(title)) {
      case 'PRONOS RECOMMANDÉS':
        return MatchListScreen(
          categoryTitle: displayTitle,
          recentMatches: mockLockedMatches,
          recentDateLabel: '08.09.2026 $displayTitle',
          historiqueMatches: mockSureMatches,
          historiqueDateLabel: '07 Sep 2026',
        );
      case 'MATCH SIMPLE':
        return MatchListScreen(
          categoryTitle: displayTitle,
          recentMatches: mockUpcomingMatches,
          recentDateLabel: '08.09.2026 $displayTitle',
          historiqueMatches: mockSimpleMatches,
          historiqueDateLabel: '07 Sep 2026',
        );
      default:
        return MatchListScreen(
          categoryTitle: displayTitle,
          recentMatches: mockUpcomingMatches,
          recentDateLabel: '08.09.2026',
          historiqueMatches: mockSimpleMatches,
          historiqueDateLabel: '07 Sep 2026',
        );
    }
  }

  /// Strips the "VIP" suffix so a VIP category matches its GRATUIT case.
  String _baseTitle(String title) =>
      title.endsWith(' VIP') ? title.substring(0, title.length - 4) : title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
          itemCount: categories.length,
          separatorBuilder: (_, _) => const SizedBox(height: 14),
          itemBuilder: (context, index) {
            final item = categories[index];
            return MenuCategoryCard(
              title: categoryDisplayTitle(item.title),
              icon: item.icon,
              iconColor: item.iconColor,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => _baseTitle(item.title) == 'DÉFI MONTANT'
                        ? const MontantChallengeScreen()
                        : _screenFor(item.title),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
