import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_language.dart';
import 'translations.dart';

const String _prefsKey = 'app_language_code';

/// Holds the language the whole app is currently displayed in.
///
/// Defaults to the device's system language when it's one of
/// [kSupportedLanguages], otherwise falls back to French. The user's
/// explicit choice (from the drawer's "Langue" picker) is persisted and
/// takes priority over the system language on the next launch.
class LocaleController extends ChangeNotifier {
  AppLanguage _current = _resolveSystemLanguage();
  bool _restored = false;

  AppLanguage get current => _current;

  Future<void> restore() async {
    if (_restored) return;
    _restored = true;
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedCode = prefs.getString(_prefsKey);
      if (savedCode != null) {
        final saved = kSupportedLanguages.where((l) => l.code == savedCode);
        if (saved.isNotEmpty && saved.first.code != _current.code) {
          _current = saved.first;
          notifyListeners();
        }
      }
    } catch (_) {
      // No persistence available (e.g. unsupported platform) — keep the
      // system-resolved language for this session.
    }
  }

  Future<void> setLanguage(AppLanguage language) async {
    if (_current.code == language.code) return;
    _current = language;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefsKey, language.code);
    } catch (_) {
      // Best effort — the choice still applies for this session.
    }
  }

  static AppLanguage _resolveSystemLanguage() {
    final systemCode = PlatformDispatcher.instance.locale.languageCode;
    final match = kSupportedLanguages.where((l) => l.code == systemCode);
    return match.isNotEmpty ? match.first : kDefaultLanguage;
  }
}

/// App-wide singleton — every screen listens to the same controller so a
/// language change rebuilds the whole app at once.
final LocaleController appLocale = LocaleController();

/// Translates [key] into the app's current language. `{placeholders}` in
/// the result are substituted from [args].
String tr(String key, [Map<String, String>? args]) =>
    translate(key, appLocale.current.code, args);
