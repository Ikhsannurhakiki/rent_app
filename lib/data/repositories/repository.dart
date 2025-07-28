

import 'package:dartz/dartz.dart' hide Unit;

import '../../common/failure.dart';
import '../entities/Unit.dart';

abstract class Repository {
  Future<Either<Failure, List<Unit>>> getUnit();
}