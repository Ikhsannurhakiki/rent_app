import 'package:dartz/dartz.dart';
import 'package:rent_app/data/repositories/repository.dart';

import '../../common/failure.dart';
import '../entities/unit_detail_entity.dart';

class GetUnitDetail {
  final Repository repository;

  GetUnitDetail(this.repository);

  Future<Either<Failure, UnitDetailEntity>> execute(int unitId) async {
    return repository.getUnitDetail(unitId);
  }


}