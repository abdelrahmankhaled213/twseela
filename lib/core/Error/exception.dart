import 'dart:io';

import 'package:dio/dio.dart';

class ServerException implements Exception {

  final String message;
  final int statusCode;

  const ServerException(this.message, this.statusCode);

}

dynamic handleDioError(DioException exception) {
  switch (exception.type) {

    case DioExceptionType.connectionError:
      throw const ServerException('No internet connection', 503);

    case DioExceptionType.badCertificate:
      throw const ServerException('Bad certificate', 495); // 495 = SSL Certificate Error

    case DioExceptionType.badResponse:

      final statusCode = exception.response?.statusCode ?? 500;
      final message = exception.response?.statusMessage ?? 'Bad response from API server';

      throw ServerException(message, statusCode);

    case DioExceptionType.connectionTimeout:
      throw const ServerException('Connection timeout with API server', 408); // Request Timeout

    case DioExceptionType.sendTimeout:
      throw const ServerException('Send timeout with API server', 408);

    case DioExceptionType.receiveTimeout:
      throw const ServerException('Receive timeout with API server', 408);

    case DioExceptionType.cancel:
      throw const ServerException('Request to API server was cancelled', 499); // Client Closed Request

    case DioExceptionType.unknown:
      if (exception.error is SocketException) {

        throw const ServerException('No internet connection', 503);
      } else {
        throw const ServerException('Unknown error occurred', 520); // 520 = Unknown Error (Cloudflare convention)
      }
  }
}
