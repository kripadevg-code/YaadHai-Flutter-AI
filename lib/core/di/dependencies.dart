import 'package:get_it/get_it.dart';
import 'package:yaad_hai/core/auth/auth_service.dart';
import 'package:yaad_hai/core/database/app_database.dart';
import 'package:yaad_hai/core/services/language_service.dart';
import 'package:yaad_hai/modules/subjects/repos/subjects_repo.dart';
import 'package:yaad_hai/modules/chapters/repos/chapters_repo.dart';
import 'package:yaad_hai/modules/concepts/repos/concepts_repo.dart';
import 'package:yaad_hai/modules/flashcards/repos/flashcards_repo.dart';
import 'package:yaad_hai/modules/quiz/repos/quiz_repo.dart';
import 'package:yaad_hai/modules/revision/repos/revision_repo.dart';
import 'package:yaad_hai/modules/mastery/repos/mastery_repo.dart';
import 'package:yaad_hai/modules/scan_history/repos/scan_history_repo.dart';
import 'package:yaad_hai/modules/scanner/repos/scanner_repo.dart';
import 'package:yaad_hai/modules/home/repos/home_repo.dart';
import 'package:yaad_hai/modules/login/repos/login_repo.dart';
import 'package:yaad_hai/modules/onboarding/repos/onboarding_repo.dart';
import 'package:yaad_hai/modules/profile/repos/profile_repo.dart';
import 'package:yaad_hai/modules/splash/repos/splash_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaad_hai/core/services/settings_service.dart';

final locator = GetIt.instance;

Future<void> setupDependencies() async {
  // ─── Core ──────────────────────────────────────────────────────────────
  final prefs = await SharedPreferences.getInstance();
  locator.registerSingleton<SettingsService>(SettingsService(prefs));
  locator.registerSingleton<LanguageService>(LanguageService(prefs));
  locator.registerSingleton<AuthService>(AuthService());
  locator.registerLazySingleton<AppDatabase>(AppDatabase.new);

  // ─── Repositories ──────────────────────────────────────────────────────
  locator.registerLazySingleton<SubjectsRepo>(() => SubjectsRepoImpl(locator<AppDatabase>()));
  locator.registerLazySingleton<ChaptersRepo>(() => ChaptersRepoImpl(locator<AppDatabase>()));
  locator.registerLazySingleton<ConceptsRepo>(() => ConceptsRepoImpl(locator<AppDatabase>()));
  locator.registerLazySingleton<FlashcardsRepo>(() => FlashcardsRepoImpl(locator<AppDatabase>()));
  locator.registerLazySingleton<QuizRepo>(() => QuizRepoImpl(locator<AppDatabase>()));
  locator.registerLazySingleton<RevisionRepo>(
    () => RevisionRepoImpl(database: locator<AppDatabase>(), masteryRepository: locator<MasteryRepo>()),
  );
  locator.registerLazySingleton<MasteryRepo>(() => MasteryRepoImpl(locator<AppDatabase>()));
  locator.registerLazySingleton<ScanHistoryRepo>(() => ScanHistoryRepoImpl(locator<AppDatabase>()));
  locator.registerLazySingleton<ScannerRepo>(
    () => ScannerRepoImpl(
      chaptersRepository: locator<ChaptersRepo>(),
      conceptsRepository: locator<ConceptsRepo>(),
      flashcardsRepository: locator<FlashcardsRepo>(),
      quizRepository: locator<QuizRepo>(),
      subjectsRepository: locator<SubjectsRepo>(),
      revisionRepository: locator<RevisionRepo>(),
      scanHistoryRepository: locator<ScanHistoryRepo>(),
    ),
  );
  locator.registerLazySingleton<HomeRepo>(
    () => HomeRepoImpl(authService: locator<AuthService>(), chaptersRepository: locator<ChaptersRepo>()),
  );
  locator.registerLazySingleton<LoginRepo>(() => LoginRepoImpl(authService: locator<AuthService>()));
  locator.registerLazySingleton<SplashRepo>(() => SplashRepoImpl(settingsService: locator<SettingsService>()));
  locator.registerLazySingleton<OnboardingRepo>(() => OnboardingRepoImpl(settingsService: locator<SettingsService>()));
  locator.registerLazySingleton<ProfileRepo>(() => ProfileRepoImpl(authService: locator<AuthService>(), database: locator<AppDatabase>()));
}
