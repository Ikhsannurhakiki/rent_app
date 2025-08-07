import 'package:equatable/equatable.dart';

import '../entities/Unit.dart';

class UnitModel extends Equatable {
  final int id;
  final int ownerId;
  final int unitTypeId;
  final String name;
  final String description;
  final double dailyRate;
  final String currency;
  final String location;
  final String availabilityStatus;
  final String thumbnailImageUrl;
  final List<String>? imageGallery;

  const UnitModel({
    required this.id,
    required this.ownerId,
    required this.unitTypeId,
    required this.name,
    required this.description,
    required this.dailyRate,
    required this.currency,
    required this.location,
    required this.availabilityStatus,
    required this.thumbnailImageUrl,
    this.imageGallery,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      id: json['unit_id'] as int,
      ownerId: json['owner_id'] as int,
      unitTypeId: json['unit_type_id'] as int,
      name: json['name'],
      description: json['description'],
      dailyRate: double.parse(json['daily_rate']),
      currency: json['currency'],
      location: json['location'],
      availabilityStatus: json['availability_status'],
      thumbnailImageUrl: json['thumbnail_image_url'],
      imageGallery: json['image_gallery'] != null
          ? List<String>.from(json['image_gallery'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unit_id': id.toString(),
      'owner_id': ownerId.toString(),
      'unit_type': unitTypeId,
      'name': name,
      'description': description,
      'daily_rate': dailyRate.toString(),
      'currency': currency,
      'location': location,
      'availability_status': availabilityStatus,
      'thumbnail_image_url': thumbnailImageUrl,
      if (imageGallery != null) 'image_gallery': imageGallery,
    };
  }

  /// 🔁 Converts `UnitModel` to domain `Unit` entity
  Unit toEntity() {
    return Unit(
      id: id,
      ownerId: ownerId,
      unitTypeId: unitTypeId,
      name: name,
      description: description,
      dailyRate: dailyRate,
      currency: currency,
      location: location,
      availabilityStatus: availabilityStatus,
      thumbnailImageUrl: thumbnailImageUrl,
      imageGallery: imageGallery,
    );
  }

  @override
  List<Object?> get props => [
    id,
    ownerId,
    unitTypeId,
    name,
    description,
    dailyRate,
    currency,
    location,
    availabilityStatus,
    thumbnailImageUrl,
    imageGallery,
  ];
}
