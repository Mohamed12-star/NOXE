/// One language the app can be displayed in.
class AppLanguage {
  final String code;
  final String nativeName;
  final String flag;

  const AppLanguage(this.code, this.nativeName, this.flag);
}

/// Every language the UI can be switched to — more than the device's own
/// system-language picker usually offers, closer to a full localization
/// app would ship with.
const List<AppLanguage> kSupportedLanguages = [
  AppLanguage('fr', 'Français', '🇫🇷'),
  AppLanguage('en', 'English', '🇬🇧'),
  AppLanguage('es', 'Español', '🇪🇸'),
  AppLanguage('pt', 'Português', '🇵🇹'),
  AppLanguage('de', 'Deutsch', '🇩🇪'),
  AppLanguage('it', 'Italiano', '🇮🇹'),
  AppLanguage('nl', 'Nederlands', '🇳🇱'),
  AppLanguage('ar', 'العربية', '🇸🇦'),
  AppLanguage('ru', 'Русский', '🇷🇺'),
  AppLanguage('tr', 'Türkçe', '🇹🇷'),
  AppLanguage('zh', '中文', '🇨🇳'),
  AppLanguage('sw', 'Kiswahili', '🇰🇪'),
];

const AppLanguage kDefaultLanguage = AppLanguage('fr', 'Français', '🇫🇷');

AppLanguage languageByCode(String code) => kSupportedLanguages.firstWhere(
      (l) => l.code == code,
      orElse: () => kDefaultLanguage,
    );
