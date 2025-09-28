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
    int _toInt(dynamic value) => int.tryParse(value.toString()) ?? 0;
    double _toDouble(dynamic value) => double.tryParse(value.toString()) ?? 0.0;
    String _toString(dynamic value) => value?.toString() ?? '';

    return UnitModel(
      id: _toInt(json['unit_id']),
      ownerId: _toInt(json['owner_id']),
      unitTypeId: _toInt(json['unit_type_id']),
      name: _toString(json['name']),
      description: _toString(json['description']),
      dailyRate: _toDouble(json['daily_rate']),
      currency: _toString(json['currency']),
      location: _toString(json['location']),
      availabilityStatus: _toString(json['availability_status']),
      thumbnailImageUrl: json['thumbnail_image_url']!.toString(),
      imageGallery: (json['image_gallery'] as List?)?.map((e) => e.toString()).toList(),
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
