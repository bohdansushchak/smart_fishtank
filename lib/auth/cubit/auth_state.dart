part of 'auth_cubit.dart';

@Freezed()
class AuthState with _$AuthState {
  const AuthState._();

  const factory AuthState({
    required bool isAuthChecking,
    @Default(false) bool isProfileFetching,
    User? user,
    Profile? profile,
  }) = _AuthState;

  factory AuthState.initial() => const AuthState(isAuthChecking: true);

  factory AuthState.signOut() => const AuthState(isAuthChecking: false);

  bool get isLoggedIn => user != null;
}
