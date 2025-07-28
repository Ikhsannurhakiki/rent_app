import '../entities/unit_entity.dart';

class UnitModel {
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

  UnitModel({
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

  /// Factory method to parse from JSON
  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      id: json['id'].toString(),
      ownerId: int.parse(json['owner_id'].toString()),
      name: json['name'],
      description: json['description'],
      unitType: json['unit_type'],
      dailyRate: double.parse(json['daily_rate'].toString()),
      currency: json['currency'],
      location: json['location'],
      availabilityStatus: json['availability_status'],
      thumbnailImageUrl: json['thumbnail_image_url'],
      imageGallery: json['image_gallery'] != null
          ? List<String>.from(json['image_gallery'])
          : null,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'owner_id': ownerId,
      'name': name,
      'description': description,
      'unit_type': unitType,
      'daily_rate': dailyRate,
      'currency': currency,
      'location': location,
      'availability_status': availabilityStatus,
      'thumbnail_image_url': thumbnailImageUrl,
      'image_gallery': imageGallery,
    };
  }

  /// Convert to Entity
  UnitEntity toEntity() {
    return UnitEntity(
      id: id,
      ownerId: ownerId,
      name: name,
      description: description,
      unitType: unitType,
      dailyRate: dailyRate,
      currency: currency,
      location: location,
      availabilityStatus: availabilityStatus,
      thumbnailImageUrl: thumbnailImageUrl,
      imageGallery: imageGallery,
    );
  }

  /// Factory from entity
  factory UnitModel.fromEntity(UnitEntity entity) {
    return UnitModel(
      id: entity.id,
      ownerId: entity.ownerId,
      name: entity.name,
      description: entity.description,
      unitType: entity.unitType,
      dailyRate: entity.dailyRate,
      currency: entity.currency,
      location: entity.location,
      availabilityStatus: entity.availabilityStatus,
      thumbnailImageUrl: entity.thumbnailImageUrl,
      imageGallery: entity.imageGallery,
    );
  }
}
