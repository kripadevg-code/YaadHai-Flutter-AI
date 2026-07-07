import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yaad_hai/core/database/app_database.dart';
import 'package:yaad_hai/core/router/app_router.dart';
import 'package:yaad_hai/modules/scanner/bloc/scanner_bloc.dart';

class AppNavigator {
  AppNavigator._();

  // ── Bottom Navigation (Top-level) ──────────────────────────────────────────
  static void goHome(BuildContext context) => context.go(AppRoutes.home);
  static void goSubjects(BuildContext context) => context.push(AppRoutes.subjects);
  static void goRevision(BuildContext context) => context.push(AppRoutes.revision);
  static void goMastery(BuildContext context) => context.push(AppRoutes.mastery);

  // ── Authentication & Onboarding ────────────────────────────────────────────
  static void goLogin(BuildContext context) => context.go(AppRoutes.login);
  static void goOnboarding(BuildContext context) => context.go(AppRoutes.onboarding);

  // ── Hierarchical Navigation (Uses Push to Preserve Stack) ──────────────────
  static void pushChapters(BuildContext context, Subject subject) {
    context.push(AppRoutes.chapters, extra: subject);
  }

  static void pushConcepts(BuildContext context, Chapter chapter) {
    context.push(AppRoutes.concepts, extra: chapter);
  }

  static void pushFlashcards(BuildContext context, Chapter chapter) {
    context.push(AppRoutes.flashcards, extra: chapter);
  }

  static void pushQuiz(BuildContext context, {required String chapterId, required String subjectId}) {
    context.push(AppRoutes.quiz, extra: {'chapterId': chapterId, 'subjectId': subjectId});
  }

  static void pushScanner(BuildContext context, {String? chapterTitle, String? chapterId, String? subjectId}) {
    context.push(
      AppRoutes.scanner,
      extra: {
        if (chapterTitle != null) 'chapterTitle': chapterTitle,
        if (chapterId != null) 'chapterId': chapterId,
        if (subjectId != null) 'subjectId': subjectId,
      },
    );
  }

  static void pushStudyPack(BuildContext context, {required String chapterId, required String chapterTitle, String? subjectId}) {
    context.push(
      AppRoutes.studyPack,
      extra: {
        'state': const ScannerState(),
        'chapterId': chapterId,
        'chapterTitle': chapterTitle,
        if (subjectId != null) 'subjectId': subjectId,
      },
    );
  }

  static void pushScanHistory(BuildContext context) => context.push(AppRoutes.scanHistory);

  static void pushProfile(BuildContext context) => context.push(AppRoutes.profile);

  // ── Shared Pop ─────────────────────────────────────────────────────────────
  static void pop(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.home);
    }
  }
}
