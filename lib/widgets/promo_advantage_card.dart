import 'package:flutter/material.dart';

import '../models/promo_model.dart';
import '../theme/app_theme.dart';

/// One row in the "Vos Avantages" list.
class PromoAdvantageCard extends StatelessWidget {
  final PromoAdvantageModel advantage;

  const PromoAdvantageCard({super.key, required this.advantage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: cardDecoration(radius: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(advantage.icon, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${advantage.emoji} ${advantage.title}',
                  style: AppTextStyles.leagueName.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  advantage.description,
                  style: AppTextStyles.chip.copyWith(
                    color: AppColors.textGrey,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
