part of 'profile_bloc.dart';

abstract class ProfileEvent {
  const ProfileEvent();
}

class ProfileEventLoad extends ProfileEvent {
  const ProfileEventLoad();
}

class ProfileEventSignOut extends ProfileEvent {
  const ProfileEventSignOut();
}
