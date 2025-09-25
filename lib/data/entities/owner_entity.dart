import 'package:equatable/equatable.dart';

class OwnerEntity extends Equatable {
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

  const OwnerEntity({
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
}