import 'package:flutter/material.dart';

import '../l10n/locale_controller.dart';
import '../models/challenge_model.dart';
import '../theme/app_theme.dart';

/// One tile in the "Résultats par jour" grid: status icon, day number,
/// locked-in odds (if any), and a status pill.
class ChallengeDayCard extends StatelessWidget {
  final ChallengeDayModel day;

  const ChallengeDayCard({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    final statusColor = _colorFor(day.status);
    final isActive = day.status == ChallengeDayStatus.inProgress;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: isActive ? Border.all(color: AppColors.primary, width: 1.5) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
            child: Icon(_iconFor(day.status), size: 18, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Text(
            tr('day_label', {'n': '${day.dayNumber}'}),
            style: AppTextStyles.teamName.copyWith(fontSize: 13),
          ),
          if (day.odds != null) ...[
            const SizedBox(height: 2),
            Text(
              tr('day_odds', {'odds': '${day.odds}'}),
              style: AppTextStyles.chip.copyWith(color: AppColors.textGrey, fontSize: 11),
            ),
          ],
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _labelFor(day.status),
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _colorFor(ChallengeDayStatus status) {
    switch (status) {
      case ChallengeDayStatus.pending:
        return AppColors.textGrey;
      case ChallengeDayStatus.inProgress:
        return AppColors.primary;
      case ChallengeDayStatus.validated:
        return AppColors.success;
    }
  }

  IconData _iconFor(ChallengeDayStatus status) {
    switch (status) {
      case ChallengeDayStatus.pending:
        return Icons.access_time_rounded;
      case ChallengeDayStatus.inProgress:
        return Icons.hourglass_top_rounded;
      case ChallengeDayStatus.validated:
        return Icons.check_rounded;
    }
  }

  String _labelFor(ChallengeDayStatus status) {
    switch (status) {
      case ChallengeDayStatus.pending:
        return tr('status_pending');
      case ChallengeDayStatus.inProgress:
        return tr('status_inProgress');
      case ChallengeDayStatus.validated:
        return tr('status_validated');
    }
  }
}
