import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rent_app/data/datasource/remote_data_source.dart';

import '../../common/exception.dart';
import '../../common/failure.dart';
import '../entities/user_entity.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth auth;
  final RemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.auth, required this.remoteDataSource});

  @override
  Future<Either<Failure, String>> registerWithFirebase({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await remoteDataSource.registerInFirebase(
        email,
        password,
      );
      return Right(userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message ?? "Firebase Auth failed"));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure("No internet connection"));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> login(
    String email,
    String password,
  ) async {
    try {
      final result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(result);
    } on FirebaseAuthException catch (e) {
      final errorMessage = switch (e.code) {
        "invalid-email" => "The email address is not valid.",
        "user-disabled" => "User disabled.",
        "user-not-found" => "No user found with this email.",
        "wrong-password" => "Wrong email/password combination.",
        _ => "Login failed. Please try again.",
      };
      throw Exception(errorMessage);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure("No internet connection"));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      return const Right(null); // sukses, tidak ada return data
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<User?> currentUser() => auth.userChanges().first;

  @override
  Future<Either<Failure, UserEntity>> saveToBackend({
    required String uid,
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    try {
      final result = await remoteDataSource.registerInBackend(
        uid: uid,
        name: name,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
      );
      return Right(result.toEntity());
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message ?? "Firebase Auth failed"));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure("No internet connection"));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getSqlUser({ required String uid}) async {
    try {
      final result = await remoteDataSource.getSqlUser(
        uid: uid,
      ); // returns UserModel
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure("No internet connection"));
    }
  }
}
