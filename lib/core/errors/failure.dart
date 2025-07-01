import 'package:dio/dio.dart';

class Failure {
  final String message;

  Failure(this.message);
}

class ErrorResponse extends Failure {
  final String error;
  final String message;
  final int code;

  ErrorResponse({
    required this.error,
    required this.message,
    required this.code,
  }) : super(message);

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      error: json['error'] ?? '',
      message: json['message'] ?? '',
      code: json['code'] ?? 0,
    );
  }
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
  factory ServerFailure.fromDiorError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with api server');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with ApiServer');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with ApiServer');
      case DioExceptionType.badCertificate:
        return ServerFailure('badCertificate with api server');

      case DioExceptionType.cancel:
        return ServerFailure('Request to ApiServer was canceld');
      case DioExceptionType.connectionError:
        return ServerFailure('No Internet Connection');
      case DioExceptionType.unknown:
        return ServerFailure('Opps There was an Error, Please try again');
      case DioExceptionType.badResponse:
        return ServerFailure('Opps There was an Error, Please try again');
    }
  }
}
