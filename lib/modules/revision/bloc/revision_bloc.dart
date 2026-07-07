import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:yaad_hai/modules/revision/models/revision_item.dart';
import 'package:yaad_hai/modules/revision/repos/revision_repo.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';

part 'revision_event.dart';
part 'revision_state.dart';

class RevisionBloc extends Bloc<RevisionEvent, RevisionState> {
  RevisionBloc({required RevisionRepo repository}) : _repository = repository, super(const RevisionState()) {
    on<RevisionEventWatch>(_onWatch);
    on<RevisionEventMarkRevised>(_onMarkRevised);
  }

  final RevisionRepo _repository;

  Future<void> _onWatch(RevisionEventWatch event, Emitter<RevisionState> emit) async {
    emit(state.copyWith(status: RevisionStatus.loading));
    await emit.forEach<List<RevisionItem>>(
      _repository.watchDueRevisionItems(),
      onData: (items) => state.copyWith(status: RevisionStatus.success, revisionItems: items),
      onError: (error, _) {
        debugPrint('RevisionBloc watch failed: $error');
        return state.copyWith(status: RevisionStatus.error, errorMessage: AppStrings.somethingWentWrong);
      },
    );
  }

  Future<void> _onMarkRevised(RevisionEventMarkRevised event, Emitter<RevisionState> emit) async {
    try {
      await _repository.markRevised(event.revisionId, event.quality);
    } catch (error) {
      debugPrint('RevisionBloc markRevised failed: $error');
      emit(state.copyWith(status: RevisionStatus.error, errorMessage: AppStrings.somethingWentWrong));
    }
  }
}
