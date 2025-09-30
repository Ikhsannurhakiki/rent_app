import 'package:dartz/dartz.dart';
import 'package:rent_app/data/entities/user_entity.dart';

import '../../../common/failure.dart';
import '../../repositories/auth_repository.dart';

class GetSqlUser {
  final AuthRepository repository;

  GetSqlUser(this.repository);

  Future<Either<Failure, UserEntity>>  execute({required String uid}) async {
    return repository.getSqlUser(uid: uid);
  }
}
