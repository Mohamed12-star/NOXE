import 'package:flutter/material.dart';

import '../l10n/app_language.dart';
import '../l10n/locale_controller.dart';
import '../theme/app_theme.dart';

/// Bottom sheet listing every supported language; tapping one switches the
/// whole app immediately via [appLocale].
Future<void> showLanguagePicker(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.cardBackground,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return SafeArea(
        top: false,
        child: ListenableBuilder(
          listenable: appLocale,
          builder: (context, _) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: AppColors.textGrey.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Text(tr('language_picker_title'), style: AppTextStyles.screenTitle.copyWith(fontSize: 17)),
                  const SizedBox(height: 8),
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: kSupportedLanguages.length,
                      itemBuilder: (context, index) {
                        final language = kSupportedLanguages[index];
                        final isSelected = language.code == appLocale.current.code;
                        return ListTile(
                          onTap: () {
                            appLocale.setLanguage(language);
                            Navigator.of(context).pop();
                          },
                          leading: Text(language.flag, style: const TextStyle(fontSize: 22)),
                          title: Text(language.nativeName, style: AppTextStyles.categoryTitle),
                          trailing: isSelected
                              ? const Icon(Icons.check_circle_rounded, color: AppColors.primary)
                              : null,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}
