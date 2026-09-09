import 'package:flutter/material.dart';

import '../l10n/locale_controller.dart';
import '../models/challenge_model.dart';
import '../theme/app_theme.dart';
import '../widgets/challenge_day_card.dart';
import '../widgets/challenge_overview_card.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/rtl_icons.dart';

/// "DÉFI MONTANT" — a stake-growth challenge screen.
///
/// RÉCENT shows the active challenge (day 1 in progress); HISTORIQUE shows
/// a past challenge close to completion.
class MontantChallengeScreen extends StatefulWidget {
  const MontantChallengeScreen({super.key});

  @override
  State<MontantChallengeScreen> createState() => _MontantChallengeScreenState();
}

class _MontantChallengeScreenState extends State<MontantChallengeScreen> {
  MatchListTab _tab = MatchListTab.recent;

  ChallengeModel get _challenge =>
      _tab == MatchListTab.recent ? mockActiveChallenge : mockPastChallenge;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: SafeArea(
        child: Column(
          children: [
            const _Header(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                children: [
                  ChallengeOverviewCard(challenge: _challenge),
                  const SizedBox(height: 16),
                  ChallengeProgressCard(challenge: _challenge),
                  const SizedBox(height: 24),
                  Text(tr('montant_results'), style: AppTextStyles.screenTitle.copyWith(fontSize: 17)),
                  const SizedBox(height: 14),
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.8,
                    children: _challenge.days
                        .map((day) => ChallengeDayCard(day: day))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        selectedTab: _tab,
        onTabSelected: (tab) => setState(() => _tab = tab),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: Icon(backIconFor(context), size: 18),
            color: AppColors.textDark,
          ),
          Expanded(
            child: Text(
              tr('montant_title'),
              textAlign: TextAlign.center,
              style: AppTextStyles.screenTitle,
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}
