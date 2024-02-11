import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_fishtank/core/repositories/user/models/profile.dart';

import '../../core/repositories/user/user_repository.dart';

part 'auth_state.dart';

part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> with ChangeNotifier {
  final UserRepository _userRepository;
  final FirebaseAuth _fbAuth;

  AuthCubit(this._fbAuth, this._userRepository) : super(AuthState.initial()) {
    _fbAuth.authStateChanges().listen((User? user) {
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
    FirebaseAuth.instance.signOut();
    emit(AuthState.signOut());
  }

  @override
  void emit(AuthState state) {
    super.emit(state);
    notifyListeners();
  }
}
