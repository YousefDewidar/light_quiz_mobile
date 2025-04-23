import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;
  Failure({required this.errMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errMessage});

  factory ServerFailure.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          errMessage: 'The connection to server time out, please try later',
        );
      case DioExceptionType.sendTimeout:
        return ServerFailure(
          errMessage: 'The connection to server time out, please try later',
        );

      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          errMessage:
              'The receive method from server time out, please try later',
        );

      case DioExceptionType.badCertificate:
        return ServerFailure(errMessage: 'Bad Certificate');

      case DioExceptionType.badResponse:
        return ServerFailure.fromBadResponse(e.response!);

      case DioExceptionType.cancel:
        return ServerFailure(
          errMessage: 'The request canceld, please try another',
        );

      case DioExceptionType.connectionError:
        return ServerFailure(errMessage: 'No internet connection');

      case DioExceptionType.unknown:
        return ServerFailure(
          errMessage: 'Opps, There is a error please try again',
        );
    }
  }

  factory ServerFailure.fromBadResponse(Response response) {
    if ([400, 401, 403].contains(response.statusCode)) {
      try {
        return ServerFailure(
          errMessage: response.data['errors']['Credentials'][0],
        );
      } catch (ee) {
        return ServerFailure(
          errMessage: response.data['errors']["Password"][0],
        );
      }
    } else if (response.statusCode == 500) {
      return ServerFailure(
        errMessage: 'The is a problem in server, please try later',
      );
    } else if (response.statusCode == 404) {
      return ServerFailure(errMessage: 'The request not found');
    } else {
      return ServerFailure(errMessage: 'There is a error please try again');
    }
  }
}
