import 'package:rent_app/data/models/spesific_detail_model.dart';
import 'package:rent_app/data/models/unit_image_model.dart';

class UnitDetailModel {
  final int unitId;
  final int ownerId;
  final String unitType;
  final String name;
  final String description;
  final double dailyRate;
  final String currency;
  final String location;
  final String availabilityStatus;
  final String? thumbnailImageUrl; // Nullable
  final DateTime createdAt;
  final DateTime updatedAt;

  // Detail spesifik (mobil, motor, atau rumah) - bisa berupa salah satu dari tipe di bawah
  final SpecificDetails? specificDetails;

  final List<UnitImageModel> images;

  UnitDetailModel({
    required this.unitId,
    required this.ownerId,
    required this.unitType,
    required this.name,
    required this.description,
    required this.dailyRate,
    required this.currency,
    required this.location,
    required this.availabilityStatus,
    this.thumbnailImageUrl,
    required this.createdAt,
    required this.updatedAt,
    this.specificDetails,
    required this.images,
  });

  // Factory constructor untuk membuat instance UnitDetail dari JSON Map
  factory UnitDetailModel.fromJson(Map<String, dynamic> json) {
    SpecificDetails? parsedSpecificDetails;
    if (json['specific_details'] != null && json['unit_type'] != null) {
      final Map<String, dynamic> detailJson = json['specific_details'];
      switch (json['unit_type']) {
        case 'car':
          parsedSpecificDetails = CarDetailModel.fromJson(detailJson);
          break;
        case 'motorcycle':
          parsedSpecificDetails = MotorcycleDetailModel.fromJson(detailJson);
          break;
        case 'house':
          parsedSpecificDetails = HouseDetailModel.fromJson(detailJson);
          break;
        default:
        // Handle unknown type or log an error
          break;
      }
    }

    return UnitDetailModel(
      unitId: int.parse(json['unit_id'].toString()),
      ownerId: int.parse(json['owner_id'].toString()),
      unitType: json['unit_type'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      dailyRate: double.parse(json['daily_rate'].toString()),
      currency: json['currency'] as String,
      location: json['location'] as String,
      availabilityStatus: json['availability_status'] as String,
      thumbnailImageUrl: json['thumbnail_image_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      specificDetails: parsedSpecificDetails,
      images: (json['images'] as List<dynamic>)
          .map((e) => UnitImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}