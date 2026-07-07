part of 'chapters_bloc.dart';

enum ChaptersStatus { initial, loading, success, error }

class ChaptersState {
  final List<Chapter> chapters;
  final ChaptersStatus status;
  final String? errorMessage;

  const ChaptersState({this.chapters = const [], this.status = ChaptersStatus.initial, this.errorMessage});

  bool get hasData => chapters.isNotEmpty;

  ChaptersState copyWith({List<Chapter>? chapters, ChaptersStatus? status, String? errorMessage}) =>
      ChaptersState(chapters: chapters ?? this.chapters, status: status ?? this.status, errorMessage: errorMessage ?? this.errorMessage);
}
