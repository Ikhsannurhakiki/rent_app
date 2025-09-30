import 'package:dartz/dartz.dart';
import 'package:rent_app/data/repositories/repository.dart';

import '../../common/failure.dart';
import '../entities/unit_detail_entity.dart';

class GetUnitDetail {
  final Repository repository;

  GetUnitDetail(this.repository);

  Future<Either<Failure, UnitDetailEntity>> execute({
    required int unitId,
    required String apiKey,
  }) async {
    return repository.getUnitDetail(unitId: unitId, apiKey: apiKey);
  }
}
