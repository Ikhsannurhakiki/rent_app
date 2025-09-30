import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rent_app/common/failure.dart';
import 'package:rent_app/data/repositories/auth_repository.dart';

class RegisterFirebaseUser {
  final AuthRepository _repo;
  RegisterFirebaseUser(this._repo);

  Future<Either<Failure, String>> execute({required String email, required String password}) {
    return _repo.registerWithFirebase(
      email: email,
      password: password,
    );
  }
}