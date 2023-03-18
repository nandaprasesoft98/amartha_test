import '../canceltokenmapkey/cancel_token_map_key.dart';
import '../canceltokenmapkey/page_and_string_cancel_token_map_key.dart';
import '../canceltokenmapkey/string_cancel_token_map_key.dart';
import '../processing/futureprocessingcancellation/default_future_processing_cancellation.dart';
import '../processing/futureprocessingcancellation/future_processing_cancellation.dart';

class ApiRequestManager {
  late Map<CancelTokenMapKey, FutureProcessingCancellation> _cancelTokenMap;
  Map<CancelTokenMapKey, FutureProcessingCancellation> get cancelTokenMap => _cancelTokenMap;

  ApiRequestManager() {
    _cancelTokenMap = <CancelTokenMapKey, FutureProcessingCancellation>{};
  }

  MapEntry<CancelTokenMapKey, FutureProcessingCancellation> addRequestToCancellationPartWithStringKey(StringCancelTokenMapKey key, {bool duplicate = false, FutureProcessingCancellation Function()? onGenerateFutureProcessingCancellation}) {
    StringCancelTokenMapKey oldStringCancelTokenMapKey = key.copy();
    StringCancelTokenMapKey newStringCancelTokenMapKey = key.copy();
    if (_cancelTokenMap.containsKey(oldStringCancelTokenMapKey)) {
      if (!duplicate) {
        _cancelTokenMap[oldStringCancelTokenMapKey]?.cancel("Cancelled");
      } else {
        int i = 1;
        while (true) {
          newStringCancelTokenMapKey.key = "${oldStringCancelTokenMapKey.key}-$i";
          if (!_cancelTokenMap.containsKey(newStringCancelTokenMapKey)) {
            break;
          }
        }
      }
    }
    late FutureProcessingCancellation futureProcessingCancellation;
    if (onGenerateFutureProcessingCancellation != null) {
      futureProcessingCancellation = onGenerateFutureProcessingCancellation();
    } else {
      futureProcessingCancellation = DefaultFutureProcessingCancellation();
    }
    _cancelTokenMap[newStringCancelTokenMapKey] = futureProcessingCancellation;
    return MapEntry<CancelTokenMapKey, FutureProcessingCancellation>(newStringCancelTokenMapKey, futureProcessingCancellation);
  }

  MapEntry<CancelTokenMapKey, FutureProcessingCancellation> addRequestToCancellationPart(String key, {bool duplicate = false, FutureProcessingCancellation Function()? onGenerateFutureProcessingCancellation}) {
    return addRequestToCancellationPartWithStringKey(StringCancelTokenMapKey(key: key));
  }

  void cancelAllDesiredPageKeyedRequest(dynamic desiredPageKey, {String? subKey}) {
    _cancelRequestBasedDesiredPageKeyedRequest(desiredPageKey, subKey);
    _removeCancelRequestBasedDesiredPageKeyedRequest(desiredPageKey, subKey);
  }

  void _cancelRequestBasedDesiredPageKeyedRequest(dynamic desiredPageKey, String? subKey) {
    _cancelTokenMap.forEach((key, value) {
      _iterateCancelRequestBasedDesiredPageKeyedRequest(key, value, subKey, desiredPageKey, (key, value) => value.cancel(), (key, value) {});
    });
  }

  void _removeCancelRequestBasedDesiredPageKeyedRequest(dynamic desiredPageKey, String? subKey) {
    _cancelTokenMap.removeWhere((key, value) {
      return _iterateCancelRequestBasedDesiredPageKeyedRequest(key, value, subKey, desiredPageKey, (key, value) => true, (key, value) => false);
    });
  }

  T _iterateCancelRequestBasedDesiredPageKeyedRequest<T>(
    CancelTokenMapKey key,
    FutureProcessingCancellation value,
    String? subKey,
    dynamic desiredPageKey,
    T Function(CancelTokenMapKey key, FutureProcessingCancellation value) onIterateCancelRequest,
    T Function(CancelTokenMapKey key, FutureProcessingCancellation value) onElseIterateCancelRequest
  ) {
    if (key is StringCancelTokenMapKey) {
      bool checkingSubKey = true;
      if (key is PageAndStringCancelTokenMapKey) {
        if (key.page is int && desiredPageKey is int) {
          if (key.page >= desiredPageKey) {
            // Marked to begin checking sub key
          } else {
            checkingSubKey = false;
          }
        } else {
          checkingSubKey = false;
        }
      }
      if (checkingSubKey) {
        if (subKey != null) {
          if (key.subKey == subKey) {
            return onIterateCancelRequest(key, value);
          }
        } else {
          return onIterateCancelRequest(key, value);
        }
      }
    }
    return onElseIterateCancelRequest(key, value);
  }

  void cancelAllRequest() {
    _cancelTokenMap.forEach((key, value) {
      value.cancel("Cancelled");
    });
    _cancelTokenMap.clear();
  }
}