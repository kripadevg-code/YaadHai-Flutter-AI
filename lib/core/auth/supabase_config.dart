import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Reads Supabase + Google credentials from the `.env` file at runtime.
///
/// Values are loaded once in `main()` via `dotenv.load()`.
/// Add your keys to `.env` (never commit it — see `.env.example`).
abstract class Env {
  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';
  static String get googleWebClientId => dotenv.env['GOOGLE_WEB_CLIENT_ID'] ?? '';
  static String get geminiApiKey => dotenv.env['GEMINI_API_KEY'] ?? '';

  /// OAuth callback URI registered in Supabase Auth → URL Configuration.
  static const String authRedirectUri = 'com.yaadhai.yaad_hai://login-callback';
}
