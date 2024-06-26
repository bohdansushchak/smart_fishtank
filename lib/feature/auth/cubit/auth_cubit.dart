import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_fishtank/core/repositories/auth/auth_repository.dart';
import 'package:smart_fishtank/core/repositories/user/models/profile.dart';

import '../../../../core/repositories/user/user_repository.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> with ChangeNotifier {
  final UserRepository _userRepository;
  final AuthRepository _authRepository;

  late StreamSubscription<User?> _authSubscription;

  AuthCubit(this._authRepository, this._userRepository)
      : super(AuthState.initial()) {
    _authSubscription = _authRepository.authStateChange.listen((User? user) {
      emit(state.copyWith(isAuthChecking: false, user: user));
      if (user != null) {
        fetchProfile();
      }
    });
  }

  Future<void> fetchProfile() async {
    emit(state.copyWith(isProfileFetching: true));
    final profile = await _userRepository.fetchMyProfile();

    emit(state.copyWith(
      profile: profile,
      isProfileFetching: false,
    ));
  }

  void signOut() {
    _authRepository.signOut();
    emit(AuthState.signOut());
  }

  @override
  void emit(AuthState state) {
    super.emit(state);
    notifyListeners();
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
