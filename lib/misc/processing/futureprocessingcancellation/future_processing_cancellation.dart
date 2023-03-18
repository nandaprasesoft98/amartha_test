import 'dart:async';

abstract class FutureProcessingCancellation<T> {
  T? _cancelError;
  T? get cancelError => _cancelError;
  late Completer<T> _completer;
  bool get isCancelled => _cancelError != null;
  Future<T> get whenCancel => _completer.future;

  FutureProcessingCancellation() {
    _completer = Completer<T>();
  }

  T generateCancelError();

  void cancel([dynamic reason]) {
    _cancelError = generateCancelError();
    if (!_completer.isCompleted) {
      _completer.complete(_cancelError);
    }
    bool test = false;
  }
}