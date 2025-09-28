
import '../entities/owner_entity.dart';

class OwnerModel {
  final int ownerId;
  final int userId;
  final int ownerProfileId;
  final DateTime registrationDate;
  final String businessName;
  final double latitude;
  final double longitude;
  final String ownerStatus;
  final String? businessProfilePictureUrl;

  const OwnerModel({
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

  factory OwnerModel.fromJson(Map<String, dynamic> json) {
    return OwnerModel(
      ownerId: int.parse(json['owner_id'].toString()),
      userId: int.parse(json['user_id'].toString()),
      ownerProfileId: int.parse(json['owner_profile_id'].toString()),
      registrationDate: DateTime.parse(json['registration_date'].toString()),
      businessName: json['business_name']?.toString() ?? '',
      latitude: double.tryParse(json['latitude'].toString()) ?? 0.0,
      longitude: double.tryParse(json['longitude'].toString()) ?? 0.0,
      ownerStatus: json['owner_status']?.toString() ?? '',
      businessProfilePictureUrl:
      json['business_profile_picture_url']?.toString(),
    );
  }

  OwnerEntity toEntity() {
    return OwnerEntity(
      ownerId: ownerId,
      userId: userId,
      ownerProfileId: ownerProfileId,
      registrationDate: registrationDate,
      businessName: businessName,
      latitude: latitude,
      longitude: longitude,
      ownerStatus: ownerStatus,
      businessProfilePictureUrl: businessProfilePictureUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'owner_id': ownerId,
      'user_id': userId,
      'owner_profile_id': ownerProfileId,
      'registration_date': registrationDate.toIso8601String(),
      'business_name': businessName,
      'latitude': latitude,
      'longitude': longitude,
      'owner_status': ownerStatus,
      'business_profile_picture_url': businessProfilePictureUrl,
    };
  }
}
