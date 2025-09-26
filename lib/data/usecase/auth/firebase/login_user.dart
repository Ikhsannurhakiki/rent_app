import 'package:firebase_auth/firebase_auth.dart';

import '../../../repositories/auth_repository.dart';

class LoginUser {
  final AuthRepository _repo;
  LoginUser(this._repo);

  Future<UserCredential> call(String email, String password) {
    return _repo.login(email, password);
  }
}