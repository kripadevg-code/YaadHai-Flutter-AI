import 'package:flutter_bloc/flutter_bloc.dart';

class FlashcardsTabState {
  final int current;
  final bool isFlipped;

  const FlashcardsTabState({this.current = 0, this.isFlipped = false});

  FlashcardsTabState copyWith({int? current, bool? isFlipped}) {
    return FlashcardsTabState(current: current ?? this.current, isFlipped: isFlipped ?? this.isFlipped);
  }
}

class FlashcardsTabCubit extends Cubit<FlashcardsTabState> {
  FlashcardsTabCubit() : super(const FlashcardsTabState());

  void flip() {
    emit(state.copyWith(isFlipped: !state.isFlipped));
  }

  void next() {
    emit(state.copyWith(current: state.current + 1, isFlipped: false));
  }

  void prev() {
    if (state.current > 0) {
      emit(state.copyWith(current: state.current - 1, isFlipped: false));
    }
  }
}
