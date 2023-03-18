import 'future_processing_cancellation.dart';

class DefaultFutureProcessingCancellation extends FutureProcessingCancellation<bool> {
  @override
  bool generateCancelError() {
    return false;
  }
}