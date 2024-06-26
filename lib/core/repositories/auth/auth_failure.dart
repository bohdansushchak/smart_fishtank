import '../failure.dart';

sealed class AuthFailure extends Failure {}

final class WrongEmailFailure extends AuthFailure {}

final class UserDisabledFailure extends AuthFailure {}

final class WrongCredentialsFailure extends AuthFailure {}
