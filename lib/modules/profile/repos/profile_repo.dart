import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yaad_hai/core/auth/auth_service.dart';
import 'package:yaad_hai/core/database/app_database.dart';
import 'package:yaad_hai/modules/profile/models/profile_user_data.dart';

abstract class ProfileRepo {
  Future<ProfileUserData> getProfileData();
  Future<void> signOut();
}

class ProfileRepoImpl implements ProfileRepo {
  ProfileRepoImpl({required AuthService authService, required AppDatabase database}) : _authService = authService, _database = database;

  final AuthService _authService;
  final AppDatabase _database;

  @override
  Future<ProfileUserData> getProfileData() async {
    final User? user = Supabase.instance.client.auth.currentUser;
    final Map<String, dynamic> meta = user?.userMetadata ?? {};

    final String displayName = meta['full_name'] as String? ?? meta['name'] as String? ?? 'User';
    final String email = user?.email ?? '';
    final String? avatarUrl = meta['avatar_url'] as String?;

    // Aggregate stats from local database
    final subjects = await _database.watchSubjects().first;
    final subjectCount = subjects.length;

    final totalConcepts = await _database.getTotalConceptsCount();
    final masteredConcepts = await _database.getMasteredConceptsCount();

    final double masteryScore = totalConcepts > 0 ? masteredConcepts / totalConcepts : 0.0;

    // Streak from dedicated table
    final streak = await _database.getStreak();
    final currentStreak = streak?.currentStreak ?? 0;

    return ProfileUserData(
      displayName: displayName,
      email: email,
      initials: _initialsFromName(displayName),
      avatarUrl: avatarUrl,
      subjectCount: subjectCount,
      conceptCount: totalConcepts,
      masteryScore: masteryScore.clamp(0.0, 1.0),
      currentStreak: currentStreak,
    );
  }

  @override
  Future<void> signOut() => _authService.signOut();

  String _initialsFromName(String name) {
    final parts = name.trim().split(' ').where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return 'U';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }
}
