import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:yaad_hai/modules/splash/models/splash_destination.dart';
import 'package:yaad_hai/modules/splash/repos/splash_repo.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc({required SplashRepo repository}) : _repository = repository, super(const SplashState()) {
    on<SplashEventResolveDestination>(_onResolveDestination);
  }

  final SplashRepo _repository;

  Future<void> _onResolveDestination(SplashEventResolveDestination event, Emitter<SplashState> emit) async {
    emit(state.copyWith(status: SplashStatus.loading));
    try {
      final results = await Future.wait([_repository.resolveDestination(), Future.delayed(const Duration(milliseconds: 1500))]);
      final SplashDestination destination = results[0] as SplashDestination;
      emit(state.copyWith(status: SplashStatus.ready, destination: destination));
    } catch (error) {
      debugPrint('SplashBloc resolve failed: $error');
      emit(state.copyWith(status: SplashStatus.ready, destination: SplashDestination.login));
    }
  }
}
