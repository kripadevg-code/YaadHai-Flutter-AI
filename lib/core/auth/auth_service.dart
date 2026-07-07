import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:yaad_hai/core/auth/supabase_config.dart';

/// Central authentication service — native Google Sign-In via [GoogleSignIn],
/// exchanged for a Supabase session using [signInWithIdToken].
///
/// After sign-in, AI features work automatically via Supabase Edge Functions —
/// no API key is fetched or stored on the client.
///
/// Registered as a singleton in [setupDependencies].
class AuthService {
  AuthService() : _googleSignIn = GoogleSignIn(serverClientId: Env.googleWebClientId, scopes: ['email', 'profile']) {
    // Print the Web Client ID to ensure the .env file changes are actually loaded
    importPackageHelper();
  }

  void importPackageHelper() {
    // Just a placeholder to allow us to import package:flutter/foundation.dart if needed,
    // but we can just use print/debugPrint if imported. Let's make sure debugPrint is imported or use print with ignore.
    // ignore: avoid_print
    print('AuthService: Loaded Web Client ID = "${Env.googleWebClientId}"');
  }

  final GoogleSignIn _googleSignIn;
  final SupabaseClient _client = Supabase.instance.client;

  // ── Getters ────────────────────────────────────────────────────────────────

  User? get currentUser => _client.auth.currentUser;
  bool get isSignedIn => currentUser != null;
  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  // ── Auth Actions ───────────────────────────────────────────────────────────

  /// Opens the native Google account picker and exchanges the ID token for
  /// a Supabase session. AI features become available immediately after.
  Future<AuthResponse> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) throw const AuthException('Sign-in cancelled.');

    final googleAuth = await googleUser.authentication;
    final idToken = googleAuth.idToken;
    if (idToken == null) throw const AuthException('No ID token received.');

    return _client.auth.signInWithIdToken(provider: OAuthProvider.google, idToken: idToken, accessToken: googleAuth.accessToken);
  }

  /// Signs out from both Google and Supabase and resets the Gemini singleton.
  Future<void> signOut() async {
    await Future.wait([_googleSignIn.signOut(), _client.auth.signOut()]);
  }
}
