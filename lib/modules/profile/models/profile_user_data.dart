class ProfileUserData {
  const ProfileUserData({
    required this.displayName,
    required this.email,
    required this.initials,
    required this.subjectCount,
    required this.conceptCount,
    required this.masteryScore,
    required this.currentStreak,
    this.avatarUrl,
  });

  final String displayName;
  final String email;
  final String initials;
  final String? avatarUrl;
  final int subjectCount;
  final int conceptCount;
  final double masteryScore; // 0.0 – 1.0
  final int currentStreak;

  String get masteryPercent => '${(masteryScore * 100).round()}%';

  ProfileUserData copyWith({
    String? displayName,
    String? email,
    String? initials,
    String? avatarUrl,
    int? subjectCount,
    int? conceptCount,
    double? masteryScore,
    int? currentStreak,
  }) {
    return ProfileUserData(
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      initials: initials ?? this.initials,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      subjectCount: subjectCount ?? this.subjectCount,
      conceptCount: conceptCount ?? this.conceptCount,
      masteryScore: masteryScore ?? this.masteryScore,
      currentStreak: currentStreak ?? this.currentStreak,
    );
  }
}
