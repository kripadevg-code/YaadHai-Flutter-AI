import 'package:flutter/foundation.dart';
import 'package:yaad_hai/core/services/settings_service.dart';

abstract class OnboardingRepo {
  Future<void> markOnboardingComplete();
}

class OnboardingRepoImpl implements OnboardingRepo {
  OnboardingRepoImpl({required SettingsService settingsService}) : _settingsService = settingsService;

  final SettingsService _settingsService;

  @override
  Future<void> markOnboardingComplete() async {
    try {
      await _settingsService.setOnboardingComplete();
    } catch (error) {
      debugPrint('OnboardingRepo markOnboardingComplete failed: $error');
      rethrow;
    }
  }
}
