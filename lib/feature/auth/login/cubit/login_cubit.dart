import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_fishtank/core/repositories/auth/auth_repository.dart';

import '../../../../core/repositories/failure.dart';

part 'login_cubit.freezed.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(LoginState.initial());

  Future<void> login(String email, String password) async {
    if (state is LoadingLoginState) {
      return;
    }

    emit(LoginState.loading());
    final res = await _authRepository.login(email, password);

    res.fold((failure) {
      emit(LoginState.failure(failure));
    }, (user) {
      emit(LoginState.success(user));
    });
  }

  void clearError() {
    emit(LoginState.initial());
  }
}
