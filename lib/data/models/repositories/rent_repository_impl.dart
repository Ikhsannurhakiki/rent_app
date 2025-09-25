import 'dart:io';

import 'package:dartz/dartz.dart' hide Unit;
import 'package:rent_app/data/entities/unit_type_entity.dart';
import 'package:rent_app/data/models/specific_detail_entity.dart';
import 'package:rent_app/data/models/unit_detail_model.dart';

import 'package:rent_app/data/repositories/repository.dart';

import '../../../common/exception.dart';
import '../../../common/failure.dart';
import '../../datasource/remote_data_source.dart';
import '../../entities/Unit.dart';

class RentRepositoryImpl implements Repository {
  final RemoteDataSource remoteDataSource;

  RentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Unit>>> getUnit() async {
    try {
      final result = await remoteDataSource.getUnit();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, UnitDetailEntity>> getUnitDetail(int unitId) async {
    try {
      final result = await remoteDataSource.getUnitDetail(unitId);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<UnitTypeEntity>>> getUnitTypes()  async {
    try {
      final result = await remoteDataSource.getUnitTypes();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, double>> getRoadDistanceInKm(double startLat, double startLng, double endLat, double endLng, String apiKey) async {
    try {
      final result = await remoteDataSource.getRoadDistanceInKm(startLat, startLng, endLat, endLng, apiKey);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure("hihihih"));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
