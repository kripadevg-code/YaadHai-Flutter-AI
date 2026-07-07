import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  final SharedPreferences _prefs;
  static const String _apiKeyKey = 'gemini_api_key_pref';

  SettingsService(this._prefs);

  static const String onboardedPreferenceKey = 'onboarded';

  String get geminiApiKey => _prefs.getString(_apiKeyKey) ?? '';

  bool get hasCompletedOnboarding => _prefs.getBool(onboardedPreferenceKey) ?? false;

  Future<void> setGeminiApiKey(String key) async {
    await _prefs.setString(_apiKeyKey, key);
  }

  Future<void> setOnboardingComplete() async {
    await _prefs.setBool(onboardedPreferenceKey, true);
  }
}
