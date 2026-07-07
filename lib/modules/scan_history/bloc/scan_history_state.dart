part of 'scan_history_bloc.dart';

enum ScanHistoryStatus { initial, loading, success, empty, error }

class ScanHistoryState {
  const ScanHistoryState({this.status = ScanHistoryStatus.initial, this.entries = const [], this.errorMessage});

  final ScanHistoryStatus status;
  final List<ScanHistoryEntry> entries;
  final String? errorMessage;

  bool get isLoading => status == ScanHistoryStatus.loading;
  bool get isEmpty => status == ScanHistoryStatus.empty;
  bool get hasData => status == ScanHistoryStatus.success;

  ScanHistoryState copyWith({ScanHistoryStatus? status, List<ScanHistoryEntry>? entries, String? errorMessage}) =>
      ScanHistoryState(status: status ?? this.status, entries: entries ?? this.entries, errorMessage: errorMessage);
}
