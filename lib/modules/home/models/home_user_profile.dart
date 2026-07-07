class HomeUserProfile {
  const HomeUserProfile({required this.displayName, required this.email, required this.initials, required this.greeting, this.avatarUrl});

  final String displayName;
  final String email;
  final String initials;
  final String greeting;
  final String? avatarUrl;
}
