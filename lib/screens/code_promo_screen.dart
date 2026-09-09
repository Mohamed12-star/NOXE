import 'package:flutter/material.dart';

import '../l10n/locale_controller.dart';
import '../models/promo_model.dart';
import '../theme/app_theme.dart';
import '../widgets/promo_advantage_card.dart';
import '../widgets/promo_code_card.dart';

/// "CODE PROMO" tab: the exclusive code, its benefits, and how to use it.
class CodePromoScreen extends StatelessWidget {
  const CodePromoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
          children: [
            Text(
              tr('codePromo_title'),
              textAlign: TextAlign.center,
              style: AppTextStyles.screenTitle.copyWith(
                color: AppColors.primaryDark,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 20),
            const PromoCodeCard(code: kPromoCode),
            const SizedBox(height: 28),
            Text(tr('codePromo_advantages'), style: AppTextStyles.screenTitle.copyWith(fontSize: 18)),
            const SizedBox(height: 14),
            for (final advantage in mockPromoAdvantages) ...[
              PromoAdvantageCard(advantage: advantage),
              const SizedBox(height: 12),
            ],
            const SizedBox(height: 8),
            _HowToUseCard(),
          ],
        ),
      ),
    );
  }
}

class _HowToUseCard extends StatelessWidget {
  const _HowToUseCard();

  @override
  Widget build(BuildContext context) {
    final steps = promoHowToSteps();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: cardDecoration(radius: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.help_outline_rounded, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  tr('codePromo_howTo'),
                  style: AppTextStyles.leagueName.copyWith(fontSize: 15),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          for (var i = 0; i < steps.length; i++) ...[
            _StepRow(number: i + 1, text: steps[i]),
            if (i != steps.length - 1) const SizedBox(height: 14),
          ],
        ],
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  final int number;
  final String text;

  const _StepRow({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
          child: Text(
            '$number',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.chip.copyWith(color: AppColors.textDark, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
