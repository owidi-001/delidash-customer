import 'dart:io';

import 'package:dio/dio.dart';

class Failure {
  final String message;
  final int statusCode;
  final Map extra;

  Failure(this.message, this.statusCode, {this.extra = const {}});
  @override
  String toString() => message;
}

Failure getException(error) {
  if (error is DioError) {
    if (error.response != null) {
      return Failure(error.message, error.response!.statusCode ?? 0,
          extra: error.response!.data
          );
    }
  }
  if (error is Exception) {
    try {
      if (error is SocketException) {
        return Failure("Please check your internet connection", 0);
      }
    } catch (_) {}
  }

  return Failure("Unable to process your request", 0);
}

class HttpResult<T> {
  factory HttpResult.error(Failure failure) = _Error;
  factory HttpResult.success(T data) = _Success;

  when(
      {required Function(Failure error) error,
      required Function(T data) success}) {}
}

class _Error<T> implements HttpResult<T> {
  final Failure error;
  _Error(this.error);
  @override
  when({
    required Function(Failure error) error,
    required Function(T data) success,
  }) {
    error(this.error);
  }
}

class _Success<T> implements HttpResult<T> {
  final T data;
  _Success(this.data);
  @override
  when({
    required Function(Failure error) error,
    required Function(T data) success,
  }) {
    success(data);
  }
}
