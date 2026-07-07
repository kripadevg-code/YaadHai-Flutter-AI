import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:yaad_hai/modules/profile/models/profile_user_data.dart';
import 'package:yaad_hai/modules/profile/repos/profile_repo.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required ProfileRepo repository}) : _repository = repository, super(const ProfileState()) {
    on<ProfileEventLoad>(_onLoad);
    on<ProfileEventSignOut>(_onSignOut);
  }

  final ProfileRepo _repository;

  Future<void> _onLoad(ProfileEventLoad event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      final ProfileUserData userData = await _repository.getProfileData();
      emit(state.copyWith(status: ProfileStatus.ready, userData: userData));
    } catch (error) {
      debugPrint('ProfileBloc load failed: $error');
      emit(state.copyWith(status: ProfileStatus.error));
    }
  }

  Future<void> _onSignOut(ProfileEventSignOut event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: ProfileStatus.signingOut));
    try {
      await _repository.signOut();
      emit(state.copyWith(status: ProfileStatus.signedOut));
    } catch (error) {
      debugPrint('ProfileBloc signOut failed: $error');
      emit(state.copyWith(status: ProfileStatus.error));
    }
  }
}
