import 'dart:io';
import 'package:dio/dio.dart';

class ErrorMessage {
  final String message;
  final int statusCode;
  ErrorMessage(this.message, this.statusCode);
  @override
  String toString() => message;
}

ErrorMessage getException(error) {
  Map<String, dynamic> response;
  if (error is Exception) {
    try {
      if (error is SocketException) {
        response = {
          "message": "Please check your internet connection",
          "statusCode": 0
        };
      } else if (error is DioError) {
        switch (error.type) {
          case DioErrorType.cancel:
            response = {"message": "Api request canceled", "statusCode": 100};
            break;
          case DioErrorType.connectTimeout:
            response = {
              "message": "Connection timeout of 10000 ms exceeded",
              "statusCode": 100
            };
            break;
          case DioErrorType.response:
            switch (error.response!.statusCode) {
              case 400:
                response = {
                  "message": error.response!.data["message"] ??
                      error.response.toString(),
                  "statusCode": 400
                };
                break;
              case 401:
                response = {
                  "message": "unauthorized",
                  "statusCode": 401,
                };
                break;
              case 403:
                response = {
                  "message": "unauthorized",
                  "statusCode": 403,
                };
                break;
              case 404:
                response = {
                  "message": "Server resource not found",
                  "statusCode": 404
                };
                break;
              case 408:
                response = {"message": "Request timeout", "statusCode": 408};
                break;
              case 500:
                response = {
                  "message": "Internal sever error",
                  "statusCode": 500
                };
                break;
              case 503:
                response = {"message": "Service not found", "statusCode": 503};
                break;
              default:
                response = {
                  "message": "An error occured",
                  "statusCode": error.response!.statusCode
                };
            }
            break;
          case DioErrorType.sendTimeout:
            response = {"message": "Request timeout", "statusCode": 408};
            break;

          case DioErrorType.receiveTimeout:
            response = {"message": "Request timeout", "statusCode": 408};
            break;
          case DioErrorType.other:
            response = {
              "message": "Unexpected error occured",
              "statusCode": 408
            };
            break;
        }
      } else {
        response = {"message": "Unexpected error occured", "statusCode": 408};
      }
      return ErrorMessage(response["message"], response["statusCode"]);
    } catch (_) {
      response = {"message": "Unexpected error occured", "statusCode": 408};
    }
  } else {
    response = {"message": "Unable to process your request", "statusCode": 0};
  }
  return ErrorMessage(response["message"], response["statusCode"]);
}
