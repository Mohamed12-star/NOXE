import 'package:flutter/material.dart';

/// Color palette for the "ANNONCES" feed — a dark, gold-accented look
/// distinct from the rest of the (light) app, matching the reference
/// social-feed design.
class SocialFeedColors {
  SocialFeedColors._();

  static const Color background = Color(0xFF12152B);
  static const Color card = Color(0xFF1B2044);
  static const Color commentBubble = Color(0xFF232A56);
  static const Color header = Color(0xFFFFC72C);
  static const Color headerDark = Color(0xFFFFB300);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFA6ACC4);
  static const Color divider = Color(0x1FFFFFFF);
  static const Color like = Color(0xFFFF5C5C);

  /// Text/icon color used on top of the gold [header] bar.
  static const Color onHeader = Color(0xFF1A1A2E);
}
