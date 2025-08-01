

import 'package:dartz/dartz.dart' hide Unit;
import 'package:rent_app/data/models/specific_detail_entity.dart';
import 'package:rent_app/data/models/unit_detail_model.dart';

import '../../common/failure.dart';
import '../entities/Unit.dart';

abstract class Repository {
  Future<Either<Failure, List<Unit>>> getUnit();
  Future<Either<Failure, UnitDetailEntity>> getUnitDetail(int unitId);
}