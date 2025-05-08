
abstract class ResponseState {}

class ResponseInitial extends ResponseState {}

class ResponseLoading extends ResponseState {}

class ResponseFail extends ResponseState {
  final String errMessage;
  ResponseFail(this.errMessage);
}
