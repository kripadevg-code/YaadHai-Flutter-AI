import 'package:go_router/go_router.dart';
import 'package:yaad_hai/core/database/app_database.dart';
import 'package:yaad_hai/modules/chapters/chapters_page.dart';
import 'package:yaad_hai/modules/concepts/concepts_page.dart';
import 'package:yaad_hai/modules/flashcards/flashcards_page.dart';
import 'package:yaad_hai/modules/home/home_page.dart';
import 'package:yaad_hai/modules/login/login_page.dart';
import 'package:yaad_hai/modules/mastery/mastery_page.dart';
import 'package:yaad_hai/modules/onboarding/onboarding_page.dart';
import 'package:yaad_hai/modules/quiz/quiz_page.dart';
import 'package:yaad_hai/modules/revision/revision_page.dart';
import 'package:yaad_hai/modules/scan_history/scan_history_page.dart';
import 'package:yaad_hai/modules/scanner/scanner_page.dart';
import 'package:yaad_hai/modules/scanner/scanner_result_page.dart';
import 'package:yaad_hai/modules/scanner/bloc/scanner_bloc.dart';
import 'package:yaad_hai/modules/profile/profile_page.dart';
import 'package:yaad_hai/modules/splash/splash_page.dart';
import 'package:yaad_hai/modules/subjects/subjects_page.dart';

abstract class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String subjects = '/subjects';
  static const String chapters = '/chapters';
  static const String concepts = '/concepts';
  static const String flashcards = '/flashcards';
  static const String quiz = '/quiz';
  static const String revision = '/revision';
  static const String mastery = '/mastery';
  static const String scanner = '/scanner';
  static const String studyPack = '/study-pack';
  static const String scanHistory = '/scan-history';
  static const String profile = '/profile';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(path: AppRoutes.splash, builder: (context, state) => const SplashPage()),
    GoRoute(path: AppRoutes.login, builder: (context, state) => const LoginPage()),
    GoRoute(path: AppRoutes.onboarding, builder: (context, state) => const OnboardingPage()),
    GoRoute(path: AppRoutes.home, builder: (context, state) => const HomePage()),
    GoRoute(path: AppRoutes.subjects, builder: (context, state) => const SubjectsPage()),
    GoRoute(
      path: AppRoutes.chapters,
      builder: (context, state) {
        final subject = state.extra as Subject;
        return ChaptersPage(subject: subject);
      },
    ),
    GoRoute(
      path: AppRoutes.concepts,
      builder: (context, state) {
        final chapter = state.extra as Chapter;
        return ConceptsPage(chapter: chapter);
      },
    ),
    GoRoute(
      path: AppRoutes.flashcards,
      builder: (context, state) {
        final chapter = state.extra as Chapter;
        return FlashcardsPage(chapter: chapter);
      },
    ),
    GoRoute(
      path: AppRoutes.quiz,
      builder: (context, state) {
        final extra = state.extra as Map<String, String>;
        return QuizPage(chapterId: extra['chapterId']!, subjectId: extra['subjectId']!);
      },
    ),
    GoRoute(path: AppRoutes.revision, builder: (context, state) => const RevisionPage()),
    GoRoute(path: AppRoutes.mastery, builder: (context, state) => const MasteryPage()),
    GoRoute(
      path: AppRoutes.scanner,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return ScannerPage(
          chapterTitle: extra?['chapterTitle'] as String?,
          chapterId: extra?['chapterId'] as String?,
          subjectId: extra?['subjectId'] as String?,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.studyPack,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return ScannerResultPage(
          state: extra['state'] as ScannerState? ?? const ScannerState(),
          chapterId: extra['chapterId'] as String?,
          subjectId: extra['subjectId'] as String?,
          chapterTitle: extra['chapterTitle'] as String,
        );
      },
    ),
    GoRoute(path: AppRoutes.scanHistory, builder: (context, state) => const ScanHistoryPage()),
    GoRoute(path: AppRoutes.profile, builder: (context, state) => const ProfilePage()),
  ],
);
