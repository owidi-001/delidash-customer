// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:greens_veges/utils/constants.dart';

// class Failure {
//   final String message;
//   final int statusCode;
//   Failure(this.message, this.statusCode);
//   @override
//   String toString() => message;
// }

// Failure getException(error) {
//   if (error is Exception) {
//     try {
//       if (error is SocketException) {
//         return Failure("Please check your internet connection", 0);
//       }
//       if (error is DioError) {
//         switch (error.type) {
//           case DioErrorType.cancel:
//             return Failure("Api request canceled", 100);
//           case DioErrorType.connectTimeout:
//             return Failure("Connection timeout of $timeout ms exceeded", 0);
//           case DioErrorType.response:
//             switch (error.response.statusCode) {
//               case 400:
//                 return Failure(
//                   error.response.data["message"] ?? error.response.toString(),
//                   499,
//                 );
//               case 401:
//                 return Failure("unauthorized", 401);
//               case 403:
//                 return Failure("Forbidden", 403);
//               case 404:
//                 return Failure("Not found", 404);

//               case 408:
//                 return Failure("Timeout", 408);
//               case 500:
//                 return Failure("Internal server error", 500);

//               default:
//                 return Failure("An error occured", error.response.statusCode);
//             }
//             break;
//           case DioErrorType.sendTimeout:
//             return Failure("Timeout", 408);

//           case DioErrorType.receiveTimeout:
//             return Failure("Timeout", 408);
//           case DioErrorType.other:
//             break;
//         }
//       }
//     } catch (_) {}
//   }

//   return Failure("Unable to process your request", 0);
// }
