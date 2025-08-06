import 'package:dartz/dartz.dart';
import 'package:rent_app/data/entities/unit_type_entity.dart';
import 'package:rent_app/data/repositories/repository.dart';

import '../../common/failure.dart';

class GetUnitTypes {
  final  Repository repository;
  GetUnitTypes(this.repository);
  Future<Either<Failure, List<UnitTypeEntity>>> execute() async {
    return repository.getUnitTypes();
  }

}