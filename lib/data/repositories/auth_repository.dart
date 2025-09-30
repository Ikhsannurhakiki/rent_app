import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rent_app/data/entities/user_entity.dart';

import '../../common/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> registerWithFirebase({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> saveToBackend({
    required String uid,
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
  });

  Future<Either<Failure, UserCredential>> login(String email, String password);

  Future<Either<Failure, void>> logout();

  Future<User?> currentUser();

  Future<Either<Failure, UserEntity>> getSqlUser({required String uid});
}
