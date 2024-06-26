import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../failure.dart';
import 'auth_failure.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepository(this._firebaseAuth);

  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final res = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (res.user != null) {
        return right(_firebaseAuth.currentUser!);
      } else {
        return left(UnknownFailure());
      }
    } catch (err) {
      if (err is FirebaseAuthException) {
        final failure = switch (err.code) {
          'invalid-email' => WrongEmailFailure(),
          'user-disabled' => UserDisabledFailure(),
          'user-not-found' || 'invalid-credential' => WrongCredentialsFailure(),
          _ => null,
        };

        if (failure != null) {
          return left(failure);
        }
      }

      return left(_getFailure(err));
    }
  }

  Failure _getFailure(Object error) {
    if (error is FirebaseException) {
      if (error.code == 'network-request-failed') {
        return NetworkError(code: error.code, message: error.message);
      }
    }

    return UnknownFailure();
  }

  Future<void> signOut() => _firebaseAuth.signOut();

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();
}
