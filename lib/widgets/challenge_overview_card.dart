import 'package:flutter/material.dart';

import '../l10n/locale_controller.dart';
import '../models/challenge_model.dart';
import '../theme/app_theme.dart';

/// The 2x2 grid of stat tiles at the top of the challenge screen: minimum
/// stake, daily odds, final goal, and duration.
class ChallengeOverviewCard extends StatelessWidget {
  final ChallengeModel challenge;

  const ChallengeOverviewCard({super.key, required this.challenge});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: cardDecoration(radius: 24),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _StatTile(
                  icon: Icons.attach_money_rounded,
                  label: tr('challenge_minStake'),
                  value: '${challenge.minStakeFcfa} FCFA',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatTile(
                  icon: Icons.trending_up_rounded,
                  label: tr('challenge_dailyOdds'),
                  value: '${challenge.dailyOdds}',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _StatTile(
                  icon: Icons.flag_rounded,
                  label: tr('challenge_finalGoal'),
                  value: '${challenge.finalGoalFcfa} FCFA',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatTile(
                  icon: Icons.calendar_today_rounded,
                  label: tr('challenge_duration'),
                  value: tr('challenge_days', {'n': '${challenge.durationDays}'}),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatTile({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.screenBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primaryDark, size: 18),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyles.chip.copyWith(color: AppColors.textGrey),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            textAlign: TextAlign.center,
            style: AppTextStyles.leagueName.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

/// The "Progression" card: X/Y days, a progress bar, and a percentage.
class ChallengeProgressCard extends StatelessWidget {
  final ChallengeModel challenge;

  const ChallengeProgressCard({super.key, required this.challenge});

  @override
  Widget build(BuildContext context) {
    final percent = (challenge.progress * 100).round();

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: cardDecoration(radius: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(tr('challenge_progress'), style: AppTextStyles.leagueName.copyWith(fontSize: 16)),
              Text(
                tr('challenge_daysProgress', {
                  'done': '${challenge.completedDays}',
                  'total': '${challenge.durationDays}',
                }),
                style: AppTextStyles.chip.copyWith(
                  color: AppColors.primaryDark,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: LinearProgressIndicator(
              value: challenge.progress,
              minHeight: 8,
              backgroundColor: const Color(0xFFE9ECEF),
              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            tr('challenge_percent', {'percent': '$percent'}),
            style: AppTextStyles.chip.copyWith(color: AppColors.textGrey),
          ),
        ],
      ),
    );
  }
}
