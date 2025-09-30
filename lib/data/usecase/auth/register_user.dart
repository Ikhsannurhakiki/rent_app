import 'package:dartz/dartz.dart';
import 'package:rent_app/common/failure.dart';

import '../../entities/user_entity.dart';
import 'firebase/register_firebase_user.dart';
import 'local/register_backend_user.dart';

class RegisterUser {
  final RegisterFirebaseUser firebaseUseCase;
  final RegisterBackendUser backendUseCase;

  RegisterUser(this.firebaseUseCase, this.backendUseCase);

  Future<Either<Failure, UserEntity>> execute({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    final userCred = await firebaseUseCase.execute(
      email: email,
      password: password,
    );

    final uid = userCred.getOrElse(
          () => throw Exception("Failed to register user"),
    );

    return await backendUseCase.execute(
      uid: uid,
      name: name,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
    );
  }
}
