import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Centralized color palette for the pronostics app.
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFFFFA726);
  static const Color primaryDark = Color(0xFFFF9800);
  static const Color success = Color(0xFF2ECE89);
  static const Color fail = Color(0xFFFF5252);
  static const Color pending = Color(0xFFFFA726);

  static const Color cardBackground = Colors.white;
  static const Color screenBackground = Color(0xFFF8F9FA);

  static const Color textDark = Color(0xFF1A1A2E);
  static const Color textGrey = Color(0xFF9AA0A6);

  static const Color recentTab = Color(0xFFFFC107);
  static const Color historiqueTab = Color(0xFFFF7043);

  static const Color datePillBackground = Color(0xFF1A1A2E);

  // Root bottom navigation tabs.
  static const Color gratuitTab = Color(0xFF2ECE89);
  static const Color codePromoTab = Color(0xFFFFC107);
  static const Color vipTab = Color(0xFF8E24AA);
  static const Color annoncesTab = Color(0xFF42A5F5);
}

/// Reusable text styles built on top of Google Fonts (Poppins).
///
/// These are `static final` (computed once and cached) rather than `get`
/// (recomputed on every access) — with dozens of Text widgets rebuilding
/// per frame across the app, recreating a fresh [GoogleFonts.poppins] +
/// [TextStyle] object for every single one of them on every rebuild is
/// wasted work that adds up to visible jank, especially in Flutter's
/// slower web debug mode.
class AppTextStyles {
  AppTextStyles._();

  static final TextStyle categoryTitle = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
    letterSpacing: 0.3,
  );

  static final TextStyle screenTitle = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
    letterSpacing: 0.2,
  );

  static final TextStyle leagueName = GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
  );

  static final TextStyle teamName = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  static final TextStyle score = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
  );

  static final TextStyle predictionLabel = GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
  );

  static final TextStyle odds = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w800,
    color: Colors.white,
  );

  static final TextStyle chip = GoogleFonts.poppins(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  static final TextStyle bottomNav = GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
  );
}

/// App-wide [ThemeData].
class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    );

    return base.copyWith(
      scaffoldBackgroundColor: AppColors.screenBackground,
      textTheme: GoogleFonts.poppinsTextTheme(base.textTheme),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.screenBackground,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }
}

/// A soft, elevated card decoration shared by menu and match cards.
BoxDecoration cardDecoration({double radius = 24}) {
  return BoxDecoration(
    color: AppColors.cardBackground,
    borderRadius: BorderRadius.circular(radius),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.06),
        blurRadius: 16,
        offset: const Offset(0, 6),
      ),
    ],
  );
}
