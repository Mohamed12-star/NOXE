import 'package:flutter/material.dart';

/// Directional icon helpers so back/forward chevrons point the right way
/// under RTL languages (Arabic) instead of always pointing left/right as if
/// the UI were LTR.
IconData backIconFor(BuildContext context) =>
    Directionality.of(context) == TextDirection.rtl
        ? Icons.arrow_forward_ios_rounded
        : Icons.arrow_back_ios_new_rounded;

IconData chevronIconFor(BuildContext context) =>
    Directionality.of(context) == TextDirection.rtl
        ? Icons.chevron_left_rounded
        : Icons.chevron_right_rounded;
