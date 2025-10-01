import '../entities/owner_detail_entity.dart';

class OwnerDetailModel {
  final int ownerId;
  final String businessName;
  final String latitude;
  final String longitude;
  final String ownerStatus;
  final String businessProfilePictureUrl;
  final String registrationDate;
  final int userId;
  final String ownerName;
  final String email;
  final String phoneNumber;

  const OwnerDetailModel({
    required this.ownerId,
    required this.businessName,
    required this.latitude,
    required this.longitude,
    required this.ownerStatus,
    required this.businessProfilePictureUrl,
    required this.registrationDate,
    required this.userId,
    required this.ownerName,
    required this.email,
    required this.phoneNumber,
  });

  factory OwnerDetailModel.fromJson(Map<String, dynamic> json) {
    return OwnerDetailModel(
      ownerId: json['owner_id'] ?? 0,
      businessName: json['business_name'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      ownerStatus: json['owner_status'] ?? '',
      businessProfilePictureUrl: json['business_profile_picture_url'] ?? '',
      registrationDate: json['registration_date'] ?? '',
      userId: json['user_id'] ?? 0,
      ownerName: json['owner_name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'owner_id': ownerId,
      'business_name': businessName,
      'latitude': latitude,
      'longitude': longitude,
      'owner_status': ownerStatus,
      'business_profile_picture_url': businessProfilePictureUrl,
      'registration_date': registrationDate,
      'user_id': userId,
      'owner_name': ownerName,
      'email': email,
      'phone_number': phoneNumber,
    };
  }

  OwnerDetailEntity toEntity() {
    return OwnerDetailEntity(
      ownerId: ownerId,
      businessName: businessName,
      latitude: latitude,
      longitude: longitude,
      ownerStatus: ownerStatus,
      businessProfilePictureUrl: businessProfilePictureUrl,
      registrationDate: DateTime.tryParse(registrationDate) ?? DateTime.now(),
      userId: userId,
      ownerName: ownerName,
      email: email,
      phoneNumber: phoneNumber,
    );
  }
}
