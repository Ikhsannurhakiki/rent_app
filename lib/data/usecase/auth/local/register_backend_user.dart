import 'package:dartz/dartz.dart';
import 'package:rent_app/common/failure.dart';
import 'package:rent_app/data/repositories/auth_repository.dart';

import '../../../entities/user_entity.dart';

class RegisterBackendUser {
  final AuthRepository _repo;

  RegisterBackendUser(this._repo);

  Future<Either<Failure, UserEntity>> execute({
    required String uid,
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
  }) {
    return _repo.saveToBackend(uid: uid, name: name, email: email, password: password, phoneNumber: phoneNumber);
  }
}
