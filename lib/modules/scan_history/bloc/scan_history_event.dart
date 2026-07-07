part of 'scan_history_bloc.dart';

abstract class ScanHistoryEvent {}

class ScanHistoryEventWatch extends ScanHistoryEvent {}

class ScanHistoryEventDelete extends ScanHistoryEvent {
  ScanHistoryEventDelete(this.id);
  final String id;
}
