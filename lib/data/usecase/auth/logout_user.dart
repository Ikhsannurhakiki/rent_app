import 'package:dartz/dartz.dart';

import '../../../common/failure.dart';
import '../../repositories/auth_repository.dart';

class LogoutUser {
  final AuthRepository repository;
  LogoutUser(this.repository);

  Future<Either<Failure, void>> execute() async {
    return await repository.logout();
  }
}
