part of 'scanner_bloc.dart';

abstract class ScannerEvent {}

class ScannerEventAddPage extends ScannerEvent {
  final File file;
  ScannerEventAddPage(this.file);
}

class ScannerEventRemovePage extends ScannerEvent {
  final int index;
  ScannerEventRemovePage(this.index);
}

class ScannerEventProcess extends ScannerEvent {
  final String chapterTitle;
  final bool isHindi;
  ScannerEventProcess(this.chapterTitle, {this.isHindi = false});
}

class ScannerEventReset extends ScannerEvent {}

class ScannerEventInitCamera extends ScannerEvent {}

class ScannerEventDisposeCamera extends ScannerEvent {}

class ScannerEventTakePicture extends ScannerEvent {}

class ScannerEventPickGallery extends ScannerEvent {}

class ScannerEventSetUiMode extends ScannerEvent {
  final ScannerUiMode mode;
  ScannerEventSetUiMode(this.mode);
}

class ScannerEventSelectPreview extends ScannerEvent {
  final int index;
  ScannerEventSelectPreview(this.index);
}
