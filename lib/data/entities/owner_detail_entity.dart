class OwnerDetailEntity {
  final int ownerId;
  final String businessName;
  final String latitude;
  final String longitude;
  final String ownerStatus;
  final String businessProfilePictureUrl;
  final DateTime registrationDate;
  final int userId;
  final String ownerName;
  final String email;
  final String phoneNumber;

  const OwnerDetailEntity({
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
}
