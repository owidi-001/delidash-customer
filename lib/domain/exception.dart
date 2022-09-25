import 'dart:io';

class Failure {
  final String message;
  final int statusCode;

  Failure(this.message, this.statusCode);
  @override
  String toString() => message;
}

Failure getException(error) {
  if (error is Exception) {
    try {
      if (error is SocketException) {
        return Failure("Please check your internet connection", 0);
      }
    } catch (_) {}
  }

  return Failure("Unable to process your request", 0);
}
