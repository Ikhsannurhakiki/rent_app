import 'package:equatable/equatable.dart';
import '../entities/user_entity.dart';

class UserModel extends Equatable {
  final int userId;
  final String firebaseUid;
  final String fullName;
  final String email;
  final String? phoneNumber;
  final String? profilePictureUrl;
  final String apiKey;
  final DateTime createdAt;

  const UserModel({
    required this.userId,
    required this.firebaseUid,
    required this.fullName,
    required this.email,
    this.phoneNumber,
    this.profilePictureUrl,
    required this.apiKey,
    required this.createdAt,
  });

  /// Factory dari JSON (parse dari API backend PHP)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: int.tryParse(json['user_id'].toString()) ?? 0,
      firebaseUid: json['firebase_uid'] ?? '',
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'],
      profilePictureUrl: json['profile_picture_url'],
      apiKey: json['api_key'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  /// Convert ke JSON (untuk POST ke backend)
  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "firebase_uid": firebaseUid,
      "full_name": fullName,
      "email": email,
      "phone_number": phoneNumber,
      "profile_picture_url": profilePictureUrl,
      "api_key": apiKey,
      "created_at": createdAt.toIso8601String(),
    };
  }

  /// Mapping ke Entity (Domain Layer)
  UserEntity toEntity() {
    return UserEntity(
      userId: userId,
      firebaseUid: firebaseUid,
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      profilePictureUrl: profilePictureUrl,
      apiKey: apiKey,
      createdAt: createdAt,
    );
  }

  @override
  List<Object?> get props =>
      [userId, firebaseUid, fullName, email, phoneNumber, profilePictureUrl, apiKey, createdAt];
}
