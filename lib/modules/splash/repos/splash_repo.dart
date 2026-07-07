import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yaad_hai/core/services/settings_service.dart';
import 'package:yaad_hai/modules/splash/models/splash_destination.dart';

abstract class SplashRepo {
  Future<SplashDestination> resolveDestination();
}

class SplashRepoImpl implements SplashRepo {
  SplashRepoImpl({required SettingsService settingsService}) : _settingsService = settingsService;

  final SettingsService _settingsService;

  @override
  Future<SplashDestination> resolveDestination() async {
    try {
      final Session? session = Supabase.instance.client.auth.currentSession;
      if (session != null) return SplashDestination.home;

      if (_settingsService.hasCompletedOnboarding) {
        return SplashDestination.login;
      }
      return SplashDestination.onboarding;
    } catch (error) {
      debugPrint('SplashRepo resolveDestination failed: $error');
      return SplashDestination.login;
    }
  }
}
