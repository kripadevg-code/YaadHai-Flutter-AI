import 'package:flutter/foundation.dart';
import 'package:yaad_hai/core/auth/auth_service.dart';

abstract class LoginRepo {
  Future<void> signInWithGoogle();
}

class LoginRepoImpl implements LoginRepo {
  LoginRepoImpl({required AuthService authService}) : _authService = authService;

  final AuthService _authService;

  @override
  Future<void> signInWithGoogle() async {
    try {
      await _authService.signInWithGoogle();
    } catch (error) {
      debugPrint('LoginRepo signInWithGoogle failed: $error');
      rethrow;
    }
  }
}
