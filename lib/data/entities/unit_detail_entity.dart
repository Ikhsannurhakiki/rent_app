import 'package:equatable/equatable.dart';
import 'package:rent_app/data/entities/unit_image_entity.dart';
import 'owner_entity.dart';

class UnitDetailEntity extends Equatable {
  final int unitId;
  final int ownerId;
  final int unitTypeId;
  final String name;
  final String description;
  final double dailyRate;
  final String currency;
  final String location;
  final String availabilityStatus;
  final String? thumbnailImageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic specificDetails;
  final List<UnitImageEntity> images;
  final int ownerUserId;
  final String ownerFullName;
  final String ownerEmail;
  final String ownerPhoneNumber;
  final DateTime ownerRegistrationDate;
  final double ownerLatitude;
  final double ownerLongitude;
  final OwnerEntity? ownerDetails;

  const UnitDetailEntity({
    required this.unitId,
    required this.ownerId,
    required this.unitTypeId,
    required this.name,
    required this.description,
    required this.dailyRate,
    required this.currency,
    required this.location,
    required this.availabilityStatus,
    required this.thumbnailImageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.specificDetails,
    required this.images,
    required this.ownerUserId,
    required this.ownerFullName,
    required this.ownerEmail,
    required this.ownerPhoneNumber,
    required this.ownerRegistrationDate,
    required this.ownerLatitude,
    required this.ownerLongitude,
    required this.ownerDetails,
  });

  @override
  List<Object?> get props => [
    unitId,
    ownerId,
    unitTypeId,
    name,
    description,
    dailyRate,
    currency,
    location,
    availabilityStatus,
    thumbnailImageUrl,
    createdAt,
    updatedAt,
    specificDetails,
    images,
    ownerUserId,
    ownerFullName,
    ownerEmail,
    ownerPhoneNumber,
    ownerRegistrationDate,
    ownerLatitude,
    ownerLongitude,
    ownerDetails,
  ];
}
