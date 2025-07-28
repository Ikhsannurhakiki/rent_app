class UnitEntity {
  final String id;
  final int ownerId;
  final String name;
  final String description;
  final String unitType;
  final double dailyRate;
  final String currency;
  final String location;
  final String availabilityStatus;
  final String thumbnailImageUrl;
  final List<String>? imageGallery;

  const UnitEntity({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.description,
    required this.unitType,
    required this.dailyRate,
    required this.currency,
    required this.location,
    required this.availabilityStatus,
    required this.thumbnailImageUrl,
    this.imageGallery,
  });
}
