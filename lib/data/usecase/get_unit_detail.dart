import 'package:dartz/dartz.dart';
import 'package:rent_app/data/models/specific_detail_entity.dart';
import 'package:rent_app/data/models/unit_detail_model.dart';
import 'package:rent_app/data/repositories/repository.dart';

import '../../common/failure.dart';

class GetUnitDetail {
  final Repository repository;

  GetUnitDetail(this.repository);

  Future<Either<Failure, UnitDetailEntity>> execute(int unitId) async {
    return repository.getUnitDetail(unitId);
  }


}