part of 'splash_bloc.dart';

enum SplashStatus { initial, loading, ready }

class SplashState {
  const SplashState({this.status = SplashStatus.initial, this.destination});

  final SplashStatus status;
  final SplashDestination? destination;

  SplashState copyWith({SplashStatus? status, SplashDestination? destination}) {
    return SplashState(status: status ?? this.status, destination: destination ?? this.destination);
  }
}
