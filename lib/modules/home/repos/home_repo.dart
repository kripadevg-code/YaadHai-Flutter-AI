import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yaad_hai/core/auth/auth_service.dart';
import 'package:yaad_hai/core/database/app_database.dart';
import 'package:yaad_hai/modules/chapters/repos/chapters_repo.dart';
import 'package:yaad_hai/modules/home/models/home_user_profile.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';

abstract class HomeRepo {
  HomeUserProfile getCurrentUserProfile();
  Future<Chapter?> getChapterById(String chapterId);
  Future<void> signOut();
}

class HomeRepoImpl implements HomeRepo {
  HomeRepoImpl({required AuthService authService, required ChaptersRepo chaptersRepository})
    : _authService = authService,
      _chaptersRepository = chaptersRepository;

  final AuthService _authService;
  final ChaptersRepo _chaptersRepository;

  @override
  HomeUserProfile getCurrentUserProfile() {
    final User? user = Supabase.instance.client.auth.currentUser;
    final Map<String, dynamic> metadata = user?.userMetadata ?? {};
    final String displayName = metadata['full_name'] as String? ?? metadata['name'] as String? ?? AppStrings.defaultUserName;
    final String email = user?.email ?? '';
    final String? avatarUrl = metadata['avatar_url'] as String?;

    return HomeUserProfile(
      displayName: displayName,
      email: email,
      initials: _initialsFromName(displayName),
      greeting: _greetingForHour(DateTime.now().hour),
      avatarUrl: avatarUrl,
    );
  }

  @override
  Future<Chapter?> getChapterById(String chapterId) => _chaptersRepository.getChapterById(chapterId);

  @override
  Future<void> signOut() => _authService.signOut();

  String _greetingForHour(int hour) {
    if (hour < 12) return AppStrings.goodMorning;
    if (hour < 17) return AppStrings.goodAfternoon;
    return AppStrings.goodEvening;
  }

  String _initialsFromName(String name) {
    final List<String> parts = name.trim().split(' ').where((part) => part.isNotEmpty).toList();
    if (parts.isEmpty) return AppStrings.defaultUserInitial;
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }
}
