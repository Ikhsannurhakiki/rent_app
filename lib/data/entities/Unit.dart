import 'package:equatable/equatable.dart';

class Unit extends Equatable {
  Unit({
    required this.id,
    required this.name,
    required this.description,
    required this.unitTypeId,
    required this.dailyRate,
    required this.currency,
    required this.location,
    required this.availabilityStatus,
    required this.thumbnailImageUrl,
    required this.ownerId,
    this.imageGallery,
  });

  final int id;
  final String name;
  final String? description;
  final int unitTypeId;
  final double dailyRate;
  final String currency;
  final String location;
  final String availabilityStatus;
  final String thumbnailImageUrl;
  final int ownerId;
  final List<String>? imageGallery;

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    unitTypeId,
    dailyRate,
    currency,
    location,
    availabilityStatus,
    thumbnailImageUrl,
    ownerId,
    imageGallery,
  ];
}
