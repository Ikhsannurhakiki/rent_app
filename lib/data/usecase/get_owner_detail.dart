import 'package:dartz/dartz.dart';
import 'package:rent_app/data/entities/owner_detail_entity.dart';
import 'package:rent_app/data/repositories/repository.dart';

import '../../common/failure.dart';

class GetOwnerDetail{
  final Repository repository;
  GetOwnerDetail(this.repository);
  Future<Either<Failure, OwnerDetailEntity>> execute({required int ownerId, required String apiKey}) async{
    return repository.getOwnerDetail(ownerId: ownerId, apiKey: apiKey);
  }
}