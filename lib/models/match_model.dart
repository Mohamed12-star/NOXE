import 'package:flutter/material.dart';

import '../l10n/locale_controller.dart';

/// Maps a category's stable (French) identifier to its translation key.
/// Categories exclusive to VIP ('+50 ODDS', 'HT/FT') keep the English
/// betting-term spelling in every language, like "VIP" itself.
const Map<String, String> _categoryTranslationKeys = {
  'PRONOS RECOMMANDÉS': 'cat_pronosRecommandes',
  'PLUS/MOINS DE BUTS': 'cat_plusMoinsDeButs',
  'MATCH SIMPLE': 'cat_matchSimple',
  'TOP 5 DU JOUR': 'cat_top5DuJour',
  'SCORE EXACT': 'cat_scoreExact',
  'BASKETBALL': 'cat_basketball',
  'DÉFI MONTANT': 'cat_defiMontant',
  '+50 ODDS': 'cat_plus50Odds',
  'HT/FT': 'cat_htFt',
};

/// Translates a category's display title (e.g. 'PRONOS RECOMMANDÉS' or its
/// VIP variant 'PRONOS RECOMMANDÉS VIP') into the app's current language.
/// The raw, untranslated title stays the stable identifier used for
/// switch-casing elsewhere (see [MainMenuScreen]) — only the rendered text
/// changes here.
String categoryDisplayTitle(String rawTitle) {
  final isVip = rawTitle.endsWith(' VIP');
  final base = isVip ? rawTitle.substring(0, rawTitle.length - 4) : rawTitle;
  final key = _categoryTranslationKeys[base];
  final translated = key != null ? tr(key) : base;
  return isVip ? '$translated VIP' : translated;
}

/// Outcome of a match, driving the color/icon of the center pastille.
enum MatchResultStatus { win, loss, pending }

/// A single team taking part in a [MatchModel].
class TeamModel {
  final String name;

  /// Short text (initials) shown inside the placeholder logo circle.
  final String initials;

  final Color logoColor;

  const TeamModel({
    required this.name,
    required this.initials,
    required this.logoColor,
  });
}

/// The recommended bet for a match, shown in the bottom banner of the card.
///
/// The label is stored as a translation key (+ optional args, e.g. the team
/// name) rather than a literal string, so it re-renders in the app's
/// current language. Pass an empty [labelKey] for the locked/no-data case.
class PredictionModel {
  final String labelKey;
  final Map<String, String>? labelArgs;
  final double odds;

  const PredictionModel({required this.labelKey, this.labelArgs, required this.odds});

  String get label => labelKey.isEmpty ? '' : tr(labelKey, labelArgs);

  String get oddsLabel => odds.toStringAsFixed(2);
}

/// A match card entry: two teams, an optional score, and a prediction.
class MatchModel {
  final String id;
  final String leagueName;
  final String flagEmoji;
  final String time;
  final MatchResultStatus status;
  final TeamModel homeTeam;
  final TeamModel awayTeam;
  final int homeScore;
  final int awayScore;
  final bool isFavorite;
  final PredictionModel prediction;

  /// When true, the card is rendered as a [ProLockedCard] instead.
  final bool isLocked;

  const MatchModel({
    required this.id,
    required this.leagueName,
    required this.flagEmoji,
    required this.time,
    required this.status,
    required this.homeTeam,
    required this.awayTeam,
    this.homeScore = 0,
    this.awayScore = 0,
    this.isFavorite = false,
    required this.prediction,
    this.isLocked = false,
  });
}

/// Menu entry shown on the main menu screen.
class MenuCategoryItem {
  final String title;
  final IconData icon;
  final Color iconColor;

  const MenuCategoryItem({
    required this.title,
    required this.icon,
    required this.iconColor,
  });
}

/// Categories shown on the GRATUIT tab.
const List<MenuCategoryItem> mockGratuitCategories = [
  MenuCategoryItem(
    title: 'PRONOS RECOMMANDÉS',
    icon: Icons.shield_rounded,
    iconColor: Color(0xFF2ECE89),
  ),
  MenuCategoryItem(
    title: 'PLUS/MOINS DE BUTS',
    icon: Icons.sports_soccer_rounded,
    iconColor: Color(0xFFAB47BC),
  ),
  MenuCategoryItem(
    title: 'MATCH SIMPLE',
    icon: Icons.stadium_rounded,
    iconColor: Color(0xFF5C6BC0),
  ),
  MenuCategoryItem(
    title: 'TOP 5 DU JOUR',
    icon: Icons.star_rounded,
    iconColor: Color(0xFFFFD54F),
  ),
  MenuCategoryItem(
    title: 'SCORE EXACT',
    icon: Icons.scoreboard_rounded,
    iconColor: Color(0xFF26A69A),
  ),
  MenuCategoryItem(
    title: 'BASKETBALL',
    icon: Icons.sports_basketball_rounded,
    iconColor: Color(0xFFFF7043),
  ),
];

/// Categories shown on the VIP tab — everything in GRATUIT (renamed with the
/// "VIP" suffix), plus categories exclusive to VIP members.
const List<MenuCategoryItem> mockVipCategories = [
  MenuCategoryItem(
    title: 'PRONOS RECOMMANDÉS VIP',
    icon: Icons.shield_rounded,
    iconColor: Color(0xFF2ECE89),
  ),
  MenuCategoryItem(
    title: 'PLUS/MOINS DE BUTS VIP',
    icon: Icons.sports_soccer_rounded,
    iconColor: Color(0xFFAB47BC),
  ),
  MenuCategoryItem(
    title: 'MATCH SIMPLE VIP',
    icon: Icons.stadium_rounded,
    iconColor: Color(0xFF5C6BC0),
  ),
  MenuCategoryItem(
    title: 'TOP 5 DU JOUR VIP',
    icon: Icons.star_rounded,
    iconColor: Color(0xFFFFD54F),
  ),
  MenuCategoryItem(
    title: 'SCORE EXACT VIP',
    icon: Icons.scoreboard_rounded,
    iconColor: Color(0xFF26A69A),
  ),
  MenuCategoryItem(
    title: 'BASKETBALL VIP',
    icon: Icons.sports_basketball_rounded,
    iconColor: Color(0xFFFF7043),
  ),
  MenuCategoryItem(
    title: 'DÉFI MONTANT VIP',
    icon: Icons.savings_rounded,
    iconColor: Color(0xFFFFB74D),
  ),
  MenuCategoryItem(
    title: '+50 ODDS VIP',
    icon: Icons.local_fire_department_rounded,
    iconColor: Color(0xFFE53935),
  ),
  MenuCategoryItem(
    title: 'HT/FT VIP',
    icon: Icons.schedule_rounded,
    iconColor: Color(0xFF7E57C2),
  ),
];

const _vitoria = TeamModel(
  name: 'Vitória',
  initials: 'VIT',
  logoColor: Color(0xFF212121),
);
const _gremio = TeamModel(
  name: 'Grêmio',
  initials: 'GRE',
  logoColor: Color(0xFF1565C0),
);
const _elche = TeamModel(
  name: 'Elche',
  initials: 'ELC',
  logoColor: Color(0xFF2E7D32),
);
const _realSociedad = TeamModel(
  name: 'Real Sociedad',
  initials: 'RSO',
  logoColor: Color(0xFF0D47A1),
);
const _estoril = TeamModel(
  name: 'Estoril Praia',
  initials: 'EST',
  logoColor: Color(0xFFFFC107),
);
const _arouca = TeamModel(
  name: 'Arouca',
  initials: 'ARO',
  logoColor: Color(0xFFFFEB3B),
);
const _udinese = TeamModel(
  name: 'Udinese',
  initials: 'UDI',
  logoColor: Color(0xFF212121),
);
const _lazio = TeamModel(
  name: 'Lazio',
  initials: 'LAZ',
  logoColor: Color(0xFF64B5F6),
);
const _getafe = TeamModel(
  name: 'Getafe',
  initials: 'GET',
  logoColor: Color(0xFF1565C0),
);
const _celta = TeamModel(
  name: 'Celta',
  initials: 'CEL',
  logoColor: Color(0xFF63992B),
);

/// "PRONOS RECOMMANDÉS" — finished matches with a settled prediction (07 Sep 2026).
final List<MatchModel> mockSureMatches = [
  MatchModel(
    id: 'sure-1',
    leagueName: 'Campeonato Brasileiro Série A',
    flagEmoji: '🇧🇷',
    time: '23:00',
    status: MatchResultStatus.loss,
    homeTeam: _vitoria,
    awayTeam: _gremio,
    homeScore: 1,
    awayScore: 0,
    isFavorite: true,
    prediction: const PredictionModel(labelKey: 'pred_over15', odds: 1.33),
  ),
  MatchModel(
    id: 'sure-2',
    leagueName: 'Primera Division',
    flagEmoji: '🇪🇸',
    time: '19:30',
    status: MatchResultStatus.win,
    homeTeam: _elche,
    awayTeam: _realSociedad,
    homeScore: 2,
    awayScore: 3,
    isFavorite: true,
    prediction:
        const PredictionModel(labelKey: 'pred_bttsYes', odds: 1.61),
  ),
  MatchModel(
    id: 'sure-3',
    leagueName: 'Primeira Liga',
    flagEmoji: '🇵🇹',
    time: '19:15',
    status: MatchResultStatus.loss,
    homeTeam: _estoril,
    awayTeam: _arouca,
    homeScore: 0,
    awayScore: 0,
    isFavorite: true,
    prediction: const PredictionModel(
      labelKey: 'pred_asianTotal',
      labelArgs: {'line': '+1.75'},
      odds: 1.30,
    ),
  ),
  MatchModel(
    id: 'sure-4',
    leagueName: 'Serie A',
    flagEmoji: '🇮🇹',
    time: '18:45',
    status: MatchResultStatus.win,
    homeTeam: _udinese,
    awayTeam: _lazio,
    homeScore: 1,
    awayScore: 2,
    isFavorite: true,
    prediction: const PredictionModel(
      labelKey: 'pred_teamWins',
      labelArgs: {'team': 'Lazio'},
      odds: 2.05,
    ),
  ),
];

/// "MATCH SIMPLE" — finished matches, simple 1X2-style prediction (07 Sep 2026).
final List<MatchModel> mockSimpleMatches = [
  MatchModel(
    id: 'simple-1',
    leagueName: 'Campeonato Brasileiro Série A',
    flagEmoji: '🇧🇷',
    time: '23:00',
    status: MatchResultStatus.win,
    homeTeam: _vitoria,
    awayTeam: _gremio,
    homeScore: 1,
    awayScore: 0,
    isFavorite: true,
    prediction: const PredictionModel(
      labelKey: 'pred_teamWins',
      labelArgs: {'team': 'Vitória'},
      odds: 1.76,
    ),
  ),
  MatchModel(
    id: 'simple-2',
    leagueName: 'Primera Division',
    flagEmoji: '🇪🇸',
    time: '19:30',
    status: MatchResultStatus.loss,
    homeTeam: _elche,
    awayTeam: _realSociedad,
    homeScore: 2,
    awayScore: 3,
    isFavorite: true,
    prediction: const PredictionModel(
      labelKey: 'pred_teamWins',
      labelArgs: {'team': 'Elche'},
      odds: 1.76,
    ),
  ),
  MatchModel(
    id: 'simple-3',
    leagueName: 'Primeira Liga',
    flagEmoji: '🇵🇹',
    time: '19:15',
    status: MatchResultStatus.loss,
    homeTeam: _estoril,
    awayTeam: _arouca,
    homeScore: 0,
    awayScore: 0,
    isFavorite: true,
    prediction: const PredictionModel(
      labelKey: 'pred_teamWins',
      labelArgs: {'team': 'Arouca'},
      odds: 1.82,
    ),
  ),
  MatchModel(
    id: 'simple-4',
    leagueName: 'Primera Division',
    flagEmoji: '🇪🇸',
    time: '17:00',
    status: MatchResultStatus.win,
    homeTeam: _getafe,
    awayTeam: _celta,
    homeScore: 1,
    awayScore: 1,
    isFavorite: true,
    prediction: const PredictionModel(
      labelKey: 'pred_teamOrDraw',
      labelArgs: {'team': 'Getafe'},
      odds: 1.35,
    ),
  ),
];

const _home = TeamModel(
  name: 'Home',
  initials: 'H',
  logoColor: Color(0xFFBDBDBD),
);
const _away = TeamModel(
  name: 'Away',
  initials: 'A',
  logoColor: Color(0xFFBDBDBD),
);
const _paeAek = TeamModel(
  name: 'PAE AEK',
  initials: 'AEK',
  logoColor: Color(0xFFFFEB3B),
);
const _lask = TeamModel(
  name: 'LASK',
  initials: 'LAS',
  logoColor: Color(0xFF212121),
);
const _nec = TeamModel(
  name: 'NEC',
  initials: 'NEC',
  logoColor: Color(0xFFD32F2F),
);
const _excelsior = TeamModel(
  name: 'Excelsior',
  initials: 'EXC',
  logoColor: Color(0xFFC62828),
);
const _clubBrugge = TeamModel(
  name: 'Club Brugge',
  initials: 'CLB',
  logoColor: Color(0xFF1565C0),
);
const _astonVilla = TeamModel(
  name: 'Aston Villa',
  initials: 'AVL',
  logoColor: Color(0xFF7B1FA2),
);

/// "MATCH SIMPLE" — upcoming fixtures, not started yet (08 Sep 2026).
final List<MatchModel> mockUpcomingMatches = [
  MatchModel(
    id: 'upcoming-1',
    leagueName: 'Copa Libertadores',
    flagEmoji: '🏆',
    time: '00:00',
    status: MatchResultStatus.pending,
    homeTeam: _home,
    awayTeam: _away,
    isFavorite: true,
    prediction: const PredictionModel(
      labelKey: 'pred_teamWins',
      labelArgs: {'team': 'Home'},
      odds: 1.76,
    ),
  ),
  MatchModel(
    id: 'upcoming-2',
    leagueName: 'UEFA Champions League',
    flagEmoji: '🇪🇺',
    time: '16:45',
    status: MatchResultStatus.pending,
    homeTeam: _paeAek,
    awayTeam: _lask,
    isFavorite: true,
    prediction: const PredictionModel(
      labelKey: 'pred_teamWins',
      labelArgs: {'team': 'LASK'},
      odds: 1.82,
    ),
  ),
  MatchModel(
    id: 'upcoming-3',
    leagueName: 'Eredivisie',
    flagEmoji: '🇳🇱',
    time: '16:45',
    status: MatchResultStatus.pending,
    homeTeam: _nec,
    awayTeam: _excelsior,
    isFavorite: true,
    prediction: const PredictionModel(
      labelKey: 'pred_teamWins',
      labelArgs: {'team': 'NEC'},
      odds: 1.76,
    ),
  ),
  MatchModel(
    id: 'upcoming-4',
    leagueName: 'UEFA Champions League',
    flagEmoji: '🇪🇺',
    time: '16:45',
    status: MatchResultStatus.pending,
    homeTeam: _clubBrugge,
    awayTeam: _astonVilla,
    isFavorite: true,
    prediction: const PredictionModel(
      labelKey: 'pred_teamWins',
      labelArgs: {'team': 'Club Brugge'},
      odds: 1.90,
    ),
  ),
];

/// "PRONOS RECOMMANDÉS" for a day still reserved to the Pro plan (08 Sep 2026).
final List<MatchModel> mockLockedMatches = List.generate(
  4,
  (index) => MatchModel(
    id: 'locked-$index',
    leagueName: '',
    flagEmoji: '',
    time: '',
    status: MatchResultStatus.pending,
    homeTeam: _home,
    awayTeam: _away,
    isLocked: true,
    prediction: const PredictionModel(labelKey: '', odds: 0),
  ),
);
