import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int userId;
  final String firebaseUid;
  final String fullName;
  final String email;
  final String? phoneNumber;
  final String? profilePictureUrl;
  final String apiKey;
  final DateTime createdAt;

  const UserEntity({
    required this.userId,
    required this.firebaseUid,
    required this.fullName,
    required this.email,
    this.phoneNumber,
    this.profilePictureUrl,
    required this.apiKey,
    required this.createdAt,
  });

  @override
  List<Object?> get props =>
      [userId, firebaseUid, fullName, email, phoneNumber, profilePictureUrl, apiKey, createdAt];
}
