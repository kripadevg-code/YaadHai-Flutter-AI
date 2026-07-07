part of 'home_bloc.dart';

enum HomeStatus { initial, loading, ready, signingOut, signedOut, error }

class HomeState {
  const HomeState({
    this.status = HomeStatus.initial,
    this.profile,
    this.errorMessage,
    this.conceptNavigationChapter,
    this.navigateToMastery = false,
  });

  final HomeStatus status;
  final HomeUserProfile? profile;
  final String? errorMessage;
  final Chapter? conceptNavigationChapter;
  final bool navigateToMastery;

  HomeState copyWith({
    HomeStatus? status,
    HomeUserProfile? profile,
    String? errorMessage,
    Chapter? conceptNavigationChapter,
    bool? navigateToMastery,
    bool clearNavigation = false,
  }) {
    return HomeState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      errorMessage: errorMessage ?? this.errorMessage,
      conceptNavigationChapter: clearNavigation ? null : conceptNavigationChapter ?? this.conceptNavigationChapter,
      navigateToMastery: clearNavigation ? false : navigateToMastery ?? this.navigateToMastery,
    );
  }
}
