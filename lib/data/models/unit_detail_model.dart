import 'package:rent_app/data/entities/specific_detail_entity.dart';
import 'package:rent_app/data/models/spesific_detail_model.dart';

import '../entities/unit_detail_entity.dart';
import 'unit_image_model.dart';
import 'owner_model.dart';

class UnitDetailModel {
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
  final List<UnitImageModel> images;

  final int ownerUserId;
  final String ownerFullName;
  final String ownerEmail;
  final String ownerPhoneNumber;
  final DateTime ownerRegistrationDate;
  final double ownerLatitude;
  final double ownerLongitude;
  final OwnerModel? ownerDetails;

  const UnitDetailModel({
    required this.unitId,
    required this.ownerId,
    required this.unitTypeId,
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
    required this.ownerUserId,
    required this.ownerFullName,
    required this.ownerEmail,
    required this.ownerPhoneNumber,
    required this.ownerRegistrationDate,
    required this.ownerLatitude,
    required this.ownerLongitude,
    this.ownerDetails,
  });

  factory UnitDetailModel.fromJson(Map<String, dynamic> json) {
    dynamic parsedSpecificDetails;
    if (json['specific_details'] != null) {
      switch ((json['unit_type_id'] is int)
          ? json['unit_type_id'] as int
          : int.parse(json['unit_type_id'].toString())) {
        case 1:
          parsedSpecificDetails = MotorcycleDetailModel.fromJson(
            json['specific_details'],
          );
          break;
        case 2:
          parsedSpecificDetails = CarDetailModel.fromJson(
            json['specific_details'],
          );
          break;
        case 3:
          parsedSpecificDetails = HouseDetailModel.fromJson(
            json['specific_details'],
          );
          break;
        default:
          break;
      }
    }

    return UnitDetailModel(
      unitId: int.parse(json['unit_id'].toString()),
      ownerId: int.parse(json['owner_id'].toString()),
      unitTypeId: int.parse(json['unit_type_id'].toString()),
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      dailyRate: double.tryParse(json['daily_rate'].toString()) ?? 0.0,
      currency: json['currency']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      availabilityStatus: json['availability_status']?.toString() ?? '',
      thumbnailImageUrl: json['thumbnail_image_url']?.toString(),
      createdAt: DateTime.parse(json['created_at'].toString()),
      updatedAt: DateTime.parse(json['updated_at'].toString()),
      specificDetails: parsedSpecificDetails,
      images: (json['images'] as List<dynamic>? ?? [])
          .map((img) => UnitImageModel.fromJson(img))
          .toList(),
      ownerUserId: int.parse(json['owner_user_id'].toString()),
      ownerFullName: json['owner_full_name']?.toString() ?? '',
      ownerEmail: json['owner_email']?.toString() ?? '',
      ownerPhoneNumber: json['owner_phone_number']?.toString() ?? '',
      ownerRegistrationDate: DateTime.parse(
        json['owner_registration_date'].toString(),
      ),
      ownerLatitude: double.tryParse(json['owner_latitude'].toString()) ?? 0.0,
      ownerLongitude:
          double.tryParse(json['owner_longitude'].toString()) ?? 0.0,
      ownerDetails: json['owner_details'] != null
          ? OwnerModel.fromJson(json['owner_details'])
          : null,
    );
  }

  UnitDetailEntity toEntity() {
    SpecificDetailsEntity? entitySpecificDetails;

    if (specificDetails != null) {
      if (specificDetails is CarDetailModel) {
        entitySpecificDetails = (specificDetails as CarDetailModel).toEntity();
      } else if (specificDetails is MotorcycleDetailModel) {
        entitySpecificDetails = (specificDetails as MotorcycleDetailModel)
            .toEntity();
      } else if (specificDetails is HouseDetailModel) {
        entitySpecificDetails = (specificDetails as HouseDetailModel)
            .toEntity();
      }
    }

    return UnitDetailEntity(
      unitId: unitId,
      ownerId: ownerId,
      unitTypeId: unitTypeId,
      name: name,
      description: description,
      dailyRate: dailyRate,
      currency: currency,
      location: location,
      availabilityStatus: availabilityStatus,
      thumbnailImageUrl: thumbnailImageUrl,
      createdAt: createdAt,
      updatedAt: updatedAt,
      specificDetails: entitySpecificDetails,
      images: images.map((imageModel) => imageModel.toEntity()).toList(),
      ownerUserId: ownerUserId,
      ownerFullName: ownerFullName,
      ownerEmail: ownerEmail,
      ownerPhoneNumber: ownerPhoneNumber,
      ownerRegistrationDate: ownerRegistrationDate,
      ownerLatitude: ownerLatitude,
      ownerLongitude: ownerLongitude,
      ownerDetails: ownerDetails?.toEntity(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unit_id': unitId,
      'owner_id': ownerId,
      'unit_type_id': unitTypeId,
      'name': name,
      'description': description,
      'daily_rate': dailyRate,
      'currency': currency,
      'location': location,
      'availability_status': availabilityStatus,
      'thumbnail_image_url': thumbnailImageUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'specific_details': specificDetails?.toJson(),
      'images': images.map((image) => image.toJson()).toList(),
      'owner_user_id': ownerUserId,
      'owner_full_name': ownerFullName,
      'owner_email': ownerEmail,
      'owner_phone_number': ownerPhoneNumber,
      'owner_registration_date': ownerRegistrationDate.toIso8601String(),
      'owner_latitude': ownerLatitude,
      'owner_longitude': ownerLongitude,
      'owner_details': ownerDetails?.toJson(),
    };
  }
}
