import 'package:flutter/material.dart';

import '../models/match_model.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/match_prediction_card.dart';
import '../widgets/pro_locked_card.dart';
import '../widgets/rtl_icons.dart';

/// Lists the matches/predictions for one category, with a "RÉCENT" /
/// "HISTORIQUE" toggle backed by two independent data sets.
class MatchListScreen extends StatefulWidget {
  final String categoryTitle;
  final List<MatchModel> recentMatches;
  final String recentDateLabel;
  final List<MatchModel> historiqueMatches;
  final String historiqueDateLabel;

  const MatchListScreen({
    super.key,
    required this.categoryTitle,
    required this.recentMatches,
    required this.recentDateLabel,
    required this.historiqueMatches,
    required this.historiqueDateLabel,
  });

  @override
  State<MatchListScreen> createState() => _MatchListScreenState();
}

class _MatchListScreenState extends State<MatchListScreen> {
  MatchListTab _tab = MatchListTab.recent;

  bool get _isRecent => _tab == MatchListTab.recent;

  List<MatchModel> get _matches =>
      _isRecent ? widget.recentMatches : widget.historiqueMatches;

  String get _dateLabel =>
      _isRecent ? widget.recentDateLabel : widget.historiqueDateLabel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: SafeArea(
        child: Column(
          children: [
            _ListHeader(title: widget.categoryTitle, dateLabel: _dateLabel),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                itemCount: _matches.length,
                itemBuilder: (context, index) {
                  final match = _matches[index];
                  if (match.isLocked) {
                    return ProLockedCard(categoryTitle: widget.categoryTitle);
                  }
                  return MatchPredictionCard(match: match);
                },
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

class _ListHeader extends StatelessWidget {
  final String title;
  final String dateLabel;

  const _ListHeader({required this.title, required this.dateLabel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  title,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.screenTitle,
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
          const SizedBox(height: 12),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.datePillBackground,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                dateLabel,
                style: AppTextStyles.chip.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
