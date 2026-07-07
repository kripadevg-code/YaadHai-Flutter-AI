import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:yaad_hai/core/database/app_database.dart';
import 'package:yaad_hai/modules/scan_history/repos/scan_history_repo.dart';

part 'scan_history_event.dart';
part 'scan_history_state.dart';

class ScanHistoryBloc extends Bloc<ScanHistoryEvent, ScanHistoryState> {
  ScanHistoryBloc({required ScanHistoryRepo repository}) : _repository = repository, super(const ScanHistoryState()) {
    on<ScanHistoryEventWatch>(_onWatch);
    on<ScanHistoryEventDelete>(_onDelete);
  }

  final ScanHistoryRepo _repository;

  void _onWatch(ScanHistoryEventWatch event, Emitter<ScanHistoryState> emit) async {
    emit(state.copyWith(status: ScanHistoryStatus.loading));
    await emit.forEach<List<ScanHistoryEntry>>(
      _repository.watchAll(),
      onData: (entries) => state.copyWith(status: entries.isEmpty ? ScanHistoryStatus.empty : ScanHistoryStatus.success, entries: entries),
      onError: (error, _) {
        debugPrint('ScanHistoryBloc watch error: $error');
        return state.copyWith(status: ScanHistoryStatus.error, errorMessage: error.toString());
      },
    );
  }

  Future<void> _onDelete(ScanHistoryEventDelete event, Emitter<ScanHistoryState> emit) async {
    try {
      await _repository.delete(event.id);
    } catch (error) {
      debugPrint('ScanHistoryBloc delete error: $error');
    }
  }
}
