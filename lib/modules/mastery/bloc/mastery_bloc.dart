// Mastery BLoC
import 'package:bloc/bloc.dart';
import 'package:yaad_hai/core/database/app_database.dart';
import 'package:yaad_hai/modules/mastery/models/subject_with_progress.dart';
import 'package:yaad_hai/modules/mastery/repos/mastery_repo.dart';

part 'mastery_event.dart';
part 'mastery_state.dart';

class MasteryBloc extends Bloc<MasteryEvent, MasteryState> {
  final MasteryRepo _repository;

  MasteryBloc({required MasteryRepo repository}) : _repository = repository, super(const MasteryState()) {
    on<MasteryEventLoad>(_onLoad);
  }

  Future<void> _onLoad(MasteryEventLoad event, Emitter<MasteryState> emit) async {
    emit(state.copyWith(status: MasteryStatus.loading));
    try {
      final totalConcepts = await _repository.getTotalConceptsCount();
      final masteredConcepts = await _repository.getMasteredConceptsCount();
      final weakConcepts = await _repository.getWeakConcepts();
      final streak = await _repository.getStreak();
      final subjects = await _repository.getAllSubjectsWithProgress();

      emit(
        state.copyWith(
          status: MasteryStatus.success,
          totalConcepts: totalConcepts,
          masteredConcepts: masteredConcepts,
          weakConcepts: weakConcepts,
          streak: streak,
          subjects: subjects,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: MasteryStatus.error, errorMessage: error.toString()));
    }
  }
}
