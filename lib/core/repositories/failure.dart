abstract class Failure {
  final String? message;
  final String? code;

  const Failure({this.message, this.code});
}

final class UnknownFailure extends Failure {}

final class NetworkError extends Failure {
  NetworkError({super.message, super.code});
}
