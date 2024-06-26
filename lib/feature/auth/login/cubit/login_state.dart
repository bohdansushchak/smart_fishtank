part of 'login_cubit.dart';

@Freezed()
class LoginState with _$LoginState {
  factory LoginState.initial() = InitialLoginState;

  factory LoginState.loading() = LoadingLoginState;

  factory LoginState.failure(Failure failure) = FailureLoginState;

  factory LoginState.success(User user) = SuccessLoginState;
}
