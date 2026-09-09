import 'package:flutter/material.dart';

import '../models/match_model.dart';
import '../theme/app_theme.dart';

/// Renders one [MatchModel]: league header, teams with score/result
/// pastille, and the bicolor prediction banner.
class MatchPredictionCard extends StatelessWidget {
  final MatchModel match;
  final VoidCallback? onFavoriteToggle;

  const MatchPredictionCard({
    super.key,
    required this.match,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      decoration: cardDecoration(radius: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Header(match: match, onFavoriteToggle: onFavoriteToggle),
          const SizedBox(height: 16),
          _TeamsRow(match: match),
          const SizedBox(height: 16),
          _PredictionBanner(prediction: match.prediction),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final MatchModel match;
  final VoidCallback? onFavoriteToggle;

  const _Header({required this.match, this.onFavoriteToggle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(match.flagEmoji, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            match.leagueName,
            style: AppTextStyles.leagueName,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        _StatusChip(status: match.status, time: match.time),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: onFavoriteToggle,
          child: Icon(
            match.isFavorite ? Icons.star_rounded : Icons.star_border_rounded,
            color: const Color(0xFFFFC107),
            size: 22,
          ),
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  final MatchResultStatus status;
  final String time;

  const _StatusChip({required this.status, required this.time});

  @override
  Widget build(BuildContext context) {
    final IconData icon;
    final Color color;
    switch (status) {
      case MatchResultStatus.win:
        icon = Icons.check_rounded;
        color = AppColors.success;
        break;
      case MatchResultStatus.loss:
        icon = Icons.check_rounded;
        color = AppColors.success;
        break;
      case MatchResultStatus.pending:
        icon = Icons.access_time_rounded;
        color = AppColors.primaryDark;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 4),
          Text(time, style: AppTextStyles.chip.copyWith(color: color)),
        ],
      ),
    );
  }
}

class _TeamsRow extends StatelessWidget {
  final MatchModel match;

  const _TeamsRow({required this.match});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _TeamColumn(team: match.homeTeam)),
        _ScoreBlock(match: match),
        Expanded(child: _TeamColumn(team: match.awayTeam)),
      ],
    );
  }
}

class _TeamColumn extends StatelessWidget {
  final TeamModel team;

  const _TeamColumn({required this.team});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: team.logoColor.withValues(alpha: 0.12),
          child: Text(
            team.initials,
            style: AppTextStyles.teamName.copyWith(color: team.logoColor),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          team.name,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.teamName,
        ),
      ],
    );
  }
}

class _ScoreBlock extends StatelessWidget {
  final MatchModel match;

  const _ScoreBlock({required this.match});

  @override
  Widget build(BuildContext context) {
    final IconData icon;
    final Color color;
    switch (match.status) {
      case MatchResultStatus.win:
        icon = Icons.check_rounded;
        color = AppColors.success;
        break;
      case MatchResultStatus.loss:
        icon = Icons.close_rounded;
        color = AppColors.fail;
        break;
      case MatchResultStatus.pending:
        icon = Icons.access_time_rounded;
        color = AppColors.primaryDark;
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${match.homeScore}', style: AppTextStyles.score),
          const SizedBox(width: 8),
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Icon(icon, size: 16, color: Colors.white),
          ),
          const SizedBox(width: 8),
          Text('${match.awayScore}', style: AppTextStyles.score),
        ],
      ),
    );
  }
}

class _PredictionBanner extends StatelessWidget {
  final PredictionModel prediction;

  const _PredictionBanner({required this.prediction});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: SizedBox(
        height: 44,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 7,
              child: Container(
                color: AppColors.primary,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  prediction.label,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.predictionLabel,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: AppColors.success,
                alignment: Alignment.center,
                child: Text(prediction.oddsLabel, style: AppTextStyles.odds),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
