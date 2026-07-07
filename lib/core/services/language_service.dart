import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Manages the app-wide display language toggle (English ↔ Hindi).
/// Hindi content is fetched via AI; English is the default stored content.
class LanguageService extends ChangeNotifier {
  LanguageService(this._prefs) {
    _isHindi = _prefs.getBool(_key) ?? false;
  }

  static const String _key = 'display_language_hindi';
  final SharedPreferences _prefs;
  bool _isHindi = false;

  bool get isHindi => _isHindi;
  String get currentLanguage => _isHindi ? 'hi' : 'en';
  String get languageLabel => _isHindi ? 'हिंदी' : 'English';
  String get toggleLabel => _isHindi ? 'Switch to English' : 'हिंदी में देखें';

  Future<void> toggle() async {
    _isHindi = !_isHindi;
    await _prefs.setBool(_key, _isHindi);
    notifyListeners();
  }

  Future<void> setHindi(bool value) async {
    if (_isHindi == value) return;
    _isHindi = value;
    await _prefs.setBool(_key, _isHindi);
    notifyListeners();
  }
}
