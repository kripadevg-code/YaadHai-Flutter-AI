import 'package:shared_preferences/shared_preferences.dart';

/// Manages simple local user preferences (onboarding state, theme, etc.).
/// The Gemini API key is NOT stored here — it lives in Supabase Secrets
/// and is accessed server-side by the Edge Functions.
class SettingsService {
  SettingsService(this._prefs);

  final SharedPreferences _prefs;

  static const String _onboardedKey = 'onboarded';

  bool get hasCompletedOnboarding => _prefs.getBool(_onboardedKey) ?? false;

  Future<void> setOnboardingComplete() async {
    await _prefs.setBool(_onboardedKey, true);
  }
}
