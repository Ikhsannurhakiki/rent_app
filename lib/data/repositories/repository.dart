import 'package:dartz/dartz.dart' hide Unit;
import 'package:rent_app/data/entities/unit_type_entity.dart';

import '../../common/failure.dart';
import '../entities/Unit.dart';
import '../entities/unit_detail_entity.dart';

abstract class Repository {
  Future<Either<Failure, List<UnitTypeEntity>>> getUnitTypes();

  Future<Either<Failure, List<Unit>>> getUnit();

  Future<Either<Failure, UnitDetailEntity>> getUnitDetail(int unitId);

  Future<Either<Failure, double>> getRoadDistanceInKm(
      double startLat, double startLng,
      double endLat, double endLng,
      String apiKey);
}
