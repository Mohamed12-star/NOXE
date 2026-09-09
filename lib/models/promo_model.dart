import 'package:flutter/material.dart';

import '../l10n/locale_controller.dart';

/// The promo code shown on the CODE PROMO tab.
const String kPromoCode = 'NOXE';

/// Ordered steps shown under "Comment utiliser le code ?", translated into
/// the app's current language.
List<String> promoHowToSteps() => [
      tr('howto_step1'),
      tr('howto_step2'),
      tr('howto_step3'),
      tr('howto_step4', {'code': kPromoCode}),
      tr('howto_step5'),
      tr('howto_step6'),
      tr('howto_step7'),
    ];

/// One benefit row listed under "Vos Avantages".
class PromoAdvantageModel {
  final String emoji;
  final IconData icon;
  final String titleKey;
  final String descriptionKey;

  const PromoAdvantageModel({
    required this.emoji,
    required this.icon,
    required this.titleKey,
    required this.descriptionKey,
  });

  String get title => tr(titleKey);
  String get description => tr(descriptionKey);
}

const List<PromoAdvantageModel> mockPromoAdvantages = [
  PromoAdvantageModel(
    emoji: '🎁',
    icon: Icons.attach_money_rounded,
    titleKey: 'promoAdv1_title',
    descriptionKey: 'promoAdv1_desc',
  ),
  PromoAdvantageModel(
    emoji: '🎂',
    icon: Icons.cake_rounded,
    titleKey: 'promoAdv2_title',
    descriptionKey: 'promoAdv2_desc',
  ),
  PromoAdvantageModel(
    emoji: '💰',
    icon: Icons.savings_rounded,
    titleKey: 'promoAdv3_title',
    descriptionKey: 'promoAdv3_desc',
  ),
  PromoAdvantageModel(
    emoji: '⭐',
    icon: Icons.group_rounded,
    titleKey: 'promoAdv4_title',
    descriptionKey: 'promoAdv4_desc',
  ),
  PromoAdvantageModel(
    emoji: '🎯',
    icon: Icons.local_offer_rounded,
    titleKey: 'promoAdv5_title',
    descriptionKey: 'promoAdv5_desc',
  ),
  PromoAdvantageModel(
    emoji: '📞',
    icon: Icons.support_agent_rounded,
    titleKey: 'promoAdv6_title',
    descriptionKey: 'promoAdv6_desc',
  ),
];
