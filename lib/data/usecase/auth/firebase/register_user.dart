import 'package:firebase_auth/firebase_auth.dart';

import '../../../repositories/auth_repository.dart';

class RegisterUser {
  final AuthRepository _repo;
  RegisterUser(this._repo);

  Future<UserCredential> call(String email, String password) {
    return _repo.register(email, password);
  }
}