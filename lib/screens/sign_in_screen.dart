import 'package:flutter/material.dart';

import '../auth/auth_controller.dart';
import '../l10n/locale_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/google_logo.dart';

/// Shown before anything else in the app until the user signs in with
/// Google — see [AuthController].
///
/// The illustration area (top) is intentionally left empty for now — it
/// will hold a Lottie/SVG animation once one is provided; see
/// [_IllustrationPlaceholder].
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE8590C), Color(0xFF160800)],
          ),
        ),
        child: SafeArea(
          child: ListenableBuilder(
            listenable: authController,
            builder: (context, _) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                child: Column(
                  children: [
                    const Spacer(flex: 3),
                    const _IllustrationPlaceholder(),
                    const Spacer(flex: 2),
                    Text(
                      tr('signIn_tagline'),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.screenTitle.copyWith(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 28),
                    if (authController.lastError != null) ...[
                      Text(
                        authController.lastError!,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.chip.copyWith(color: const Color(0xFFFFB4A8)),
                      ),
                      const SizedBox(height: 16),
                    ],
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: authController.busy ? null : authController.signInWithGoogle,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.textDark,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          elevation: 0,
                        ),
                        icon: authController.busy
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const GoogleLogo(size: 20),
                        label: Text(tr('signIn_google'), style: AppTextStyles.leagueName),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      tr('signIn_terms'),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.chip.copyWith(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Empty for now — swap for a Lottie/SVG animation once provided.
class _IllustrationPlaceholder extends StatelessWidget {
  const _IllustrationPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 160);
  }
}
