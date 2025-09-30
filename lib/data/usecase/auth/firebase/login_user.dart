import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rent_app/common/failure.dart';

import '../../../repositories/auth_repository.dart';

class LoginUser {
  final AuthRepository _repo;
  LoginUser(this._repo);

  Future<Either<Failure,UserCredential>> execute(String email, String password) {
    return _repo.login(email, password);
  }
}