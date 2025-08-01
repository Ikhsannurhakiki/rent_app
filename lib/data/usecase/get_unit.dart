

import 'package:dartz/dartz.dart' hide Unit;

import '../../common/failure.dart';
import '../entities/Unit.dart';
import '../repositories/repository.dart';

class GetUnit {
  final Repository repository;

  GetUnit(this.repository);

  Future<Either<Failure, List<Unit>>> execute() async {
    return repository.getUnit();
  }
}
