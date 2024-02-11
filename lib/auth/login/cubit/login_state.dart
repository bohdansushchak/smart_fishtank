part of 'login_cubit.dart';

@Freezed()
class LoginState with _$LoginState {
  const LoginState._();

  const factory LoginState({
    required bool isProcessing,
  }) = _LoginState;

  factory LoginState.init() => LoginState(
        isProcessing: false,
      );
}
