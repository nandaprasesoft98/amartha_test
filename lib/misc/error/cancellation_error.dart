class CancellationError extends Error {
  final String message;

  CancellationError({this.message = ""});

  @override
  String toString() {
    return 'CancellationError: $message';
  }
}