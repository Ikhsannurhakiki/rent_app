import 'dart:ffi';

import 'package:dartz/dartz.dart' hide Unit;

import '../../common/failure.dart';
import '../repositories/repository.dart';

class GetRoadDistanceInKm {
  final Repository repository;

  GetRoadDistanceInKm(this.repository);

  Future<Either<Failure, double>> execute(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
    String apiKey,
  ) async {
    return repository.getRoadDistanceInKm(
      startLat,
      startLng,
      endLat,
      endLng,
      apiKey,
    );
  }
}
