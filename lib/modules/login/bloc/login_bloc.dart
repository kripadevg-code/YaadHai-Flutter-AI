import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:yaad_hai/modules/login/repos/login_repo.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required LoginRepo repository}) : _repository = repository, super(const LoginState()) {
    on<LoginEventSignInWithGoogle>(_onSignInWithGoogle);
  }

  final LoginRepo _repository;

  Future<void> _onSignInWithGoogle(LoginEventSignInWithGoogle event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      await _repository.signInWithGoogle();
      emit(state.copyWith(status: LoginStatus.success));
    } catch (error) {
      debugPrint('LoginBloc signIn failed: $error');
      emit(state.copyWith(status: LoginStatus.error, errorMessage: AppStrings.signInFailed));
    }
  }
}
