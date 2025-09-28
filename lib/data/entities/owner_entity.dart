
import 'package:equatable/equatable.dart';

class OwnerEntity extends Equatable {
  final int ownerId;
  final int userId;
  final int ownerProfileId;
  final DateTime registrationDate;
  final String businessName;
  final double latitude;
  final double longitude;
  final String ownerStatus;
  final String? businessProfilePictureUrl;

  const OwnerEntity({
    required this.ownerId,
    required this.userId,
    required this.ownerProfileId,
    required this.registrationDate,
    required this.businessName,
    required this.latitude,
    required this.longitude,
    required this.ownerStatus,
    this.businessProfilePictureUrl,
  });

  @override
  List<Object?> get props => [
    ownerId,
    userId,
    ownerProfileId,
    registrationDate,
    businessName,
    latitude,
    longitude,
    ownerStatus,
    businessProfilePictureUrl,
  ];
}
