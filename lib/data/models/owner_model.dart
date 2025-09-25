import 'package:equatable/equatable.dart';
import 'package:rent_app/data/entities/owner_entity.dart';

class OwnerModel extends Equatable {
  final int userId;
  final String fullName;
  final String email;
  final String phoneNumber;
  final int ownerProfileId;
  final DateTime registrationDate;
  final String businessName;
  final double latitude;
  final double longitude;
  final String ownerStatus;

  const OwnerModel({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.ownerProfileId,
    required this.registrationDate,
    required this.businessName,
    required this.latitude,
    required this.longitude,
    required this.ownerStatus,
  });

  factory OwnerModel.fromJson(Map<String, dynamic> json) {
    return OwnerModel(
      userId: int.tryParse(json['user_id']?.toString() ?? '') ?? 0,
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phone_number'] as String,
      ownerProfileId: int.tryParse(json['owner_profile_id']?.toString() ?? '') ?? 0,
      registrationDate: DateTime.parse(json['registration_date'] as String),
      businessName: json['business_name'] as String,
      latitude: double.tryParse(json['latitude']?.toString() ?? '') ?? 0.0,
      longitude: double.tryParse(json['longitude']?.toString() ?? '') ?? 0.0,
      ownerStatus: json['owner_status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'full_name': fullName,
      'email': email,
      'phone_number': phoneNumber,
      'owner_profile_id': ownerProfileId,
      'registration_date': registrationDate.toIso8601String(),
      'business_name': businessName,
      'latitude': latitude,
      'longitude': longitude,
      'owner_status': ownerStatus,
    };
  }

  @override
  List<Object?> get props => [
    userId,
    fullName,
    email,
    phoneNumber,
    ownerProfileId,
    registrationDate,
    businessName,
    latitude,
    longitude,
    ownerStatus,
  ];

  OwnerEntity toEntity() {
    return OwnerEntity(
      userId: userId,
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      ownerProfileId: ownerProfileId,
      registrationDate: registrationDate,
      businessName: businessName,
      latitude: latitude,
      longitude: longitude,
      ownerStatus: ownerStatus,
    );
  }
}