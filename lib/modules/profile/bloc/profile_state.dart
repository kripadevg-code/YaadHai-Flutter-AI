part of 'profile_bloc.dart';

enum ProfileStatus { initial, loading, ready, signingOut, signedOut, error }

class ProfileState {
  const ProfileState({this.status = ProfileStatus.initial, this.userData, this.errorMessage});

  final ProfileStatus status;
  final ProfileUserData? userData;
  final String? errorMessage;

  bool get isLoading => status == ProfileStatus.loading;
  bool get isReady => status == ProfileStatus.ready;

  ProfileState copyWith({ProfileStatus? status, ProfileUserData? userData, String? errorMessage}) {
    return ProfileState(
      status: status ?? this.status,
      userData: userData ?? this.userData,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
