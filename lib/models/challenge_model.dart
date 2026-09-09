/// Status of a single day within a [ChallengeModel].
enum ChallengeDayStatus { pending, inProgress, validated }

/// One day of a stake-growth challenge.
class ChallengeDayModel {
  final int dayNumber;

  /// The odds locked in for this day. Null while the day is still pending.
  final double? odds;

  final ChallengeDayStatus status;

  const ChallengeDayModel({
    required this.dayNumber,
    this.odds,
    required this.status,
  });
}

/// A "grow your stake" challenge: a minimum stake compounds at a fixed
/// daily odd towards a final goal over [durationDays].
class ChallengeModel {
  final int minStakeFcfa;
  final double dailyOdds;
  final int finalGoalFcfa;
  final int durationDays;
  final List<ChallengeDayModel> days;

  const ChallengeModel({
    required this.minStakeFcfa,
    required this.dailyOdds,
    required this.finalGoalFcfa,
    required this.durationDays,
    required this.days,
  });

  int get completedDays =>
      days.where((day) => day.status == ChallengeDayStatus.validated).length;

  double get progress => durationDays == 0 ? 0 : completedDays / durationDays;
}

/// An active challenge, just starting (day 1 in progress).
final ChallengeModel mockActiveChallenge = ChallengeModel(
  minStakeFcfa: 4000,
  dailyOdds: 1.9,
  finalGoalFcfa: 400000,
  durationDays: 7,
  days: [
    const ChallengeDayModel(
      dayNumber: 1,
      odds: 1.96,
      status: ChallengeDayStatus.inProgress,
    ),
    for (var day = 2; day <= 7; day++)
      ChallengeDayModel(dayNumber: day, status: ChallengeDayStatus.pending),
  ],
);

/// A past challenge, mostly completed (5 of 7 days validated).
final ChallengeModel mockPastChallenge = ChallengeModel(
  minStakeFcfa: 5000,
  dailyOdds: 1.9,
  finalGoalFcfa: 650000,
  durationDays: 7,
  days: const [
    ChallengeDayModel(dayNumber: 1, odds: 1.6, status: ChallengeDayStatus.validated),
    ChallengeDayModel(dayNumber: 2, odds: 1.9, status: ChallengeDayStatus.validated),
    ChallengeDayModel(dayNumber: 3, odds: 1.87, status: ChallengeDayStatus.validated),
    ChallengeDayModel(dayNumber: 4, odds: 2.2, status: ChallengeDayStatus.validated),
    ChallengeDayModel(dayNumber: 5, odds: 1.91, status: ChallengeDayStatus.validated),
    ChallengeDayModel(dayNumber: 6, odds: 1.86, status: ChallengeDayStatus.inProgress),
    ChallengeDayModel(dayNumber: 7, status: ChallengeDayStatus.pending),
  ],
);
