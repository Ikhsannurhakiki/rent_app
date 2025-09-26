import 'package:firebase_auth/firebase_auth.dart';

import '../../../repositories/auth_repository.dart';

class GetCurrentUser {
  final AuthRepository _repo;

  GetCurrentUser(this._repo);

  Future<User?> call() {
    return _repo.currentUser();
  }
}