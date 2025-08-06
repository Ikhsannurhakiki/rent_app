// lib/domain/entities/unit_detail_entity.dart
import 'package:equatable/equatable.dart';

// Abstract class untuk detail spesifik Entity
abstract class SpecificDetailsEntity extends Equatable {}

class UnitDetailEntity extends Equatable {
  final int unitId;
  final int ownerId;
  final String unitType;
  final String name;
  final String description;
  final double dailyRate;
  final String currency;
  final String location;
  final String availabilityStatus;
  final String? thumbnailImageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  final SpecificDetailsEntity? specificDetails;
  final List<UnitImageEntity> images;

  const UnitDetailEntity({
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

  @override
  List<Object?> get props => [
    unitId,
    ownerId,
    unitType,
    name,
    description,
    dailyRate,
    currency,
    location,
    availabilityStatus,
    thumbnailImageUrl,
    createdAt,
    updatedAt,
    specificDetails,
    images,
  ];
}

// lib/domain/entities/car_detail_entity.dart
class CarDetailEntity extends SpecificDetailsEntity {
  final int carDetailId;
  final int unitId;
  final String make;
  final String model;
  final int year;
  final String transmission;
  final String fuelType;
  final int passengerCapacity;
  final String licensePlate;
  final String color;
  final String subType;
  final String engine;

  CarDetailEntity({
    required this.carDetailId,
    required this.unitId,
    required this.make,
    required this.model,
    required this.year,
    required this.transmission,
    required this.fuelType,
    required this.passengerCapacity,
    required this.licensePlate,
    required this.color,
    required this.subType,
    required this.engine,
  });

  @override
  List<Object?> get props => [
    carDetailId,
    unitId,
    make,
    model,
    year,
    transmission,
    fuelType,
    passengerCapacity,
    licensePlate,
    color,
    subType,
    engine,
  ];
}

// lib/domain/entities/motorcycle_detail_entity.dart
class MotorcycleDetailEntity extends SpecificDetailsEntity {
  final int motorcycleDetailId;
  final int unitId;
  final String make;
  final String model;
  final int year;
  final int engineCc;
  final String transmission;
  final String licensePlate;
  final String color;

  MotorcycleDetailEntity({
    required this.motorcycleDetailId,
    required this.unitId,
    required this.make,
    required this.model,
    required this.year,
    required this.engineCc,
    required this.transmission,
    required this.licensePlate,
    required this.color,
  });

  @override
  List<Object?> get props => [
    motorcycleDetailId,
    unitId,
    make,
    model,
    year,
    engineCc,
    transmission,
    licensePlate,
    color,
  ];
}

// lib/domain/entities/house_detail_entity.dart
class HouseDetailEntity extends SpecificDetailsEntity {
  final int houseDetailId;
  final int unitId;
  final int numBedrooms;
  final int numBathrooms;
  final double areaSqm;
  final String propertyType;
  final String fullAddress;
  final String city;
  final String province;
  final String postalCode;
  final String? amenities;

  HouseDetailEntity({
    required this.houseDetailId,
    required this.unitId,
    required this.numBedrooms,
    required this.numBathrooms,
    required this.areaSqm,
    required this.propertyType,
    required this.fullAddress,
    required this.city,
    required this.province,
    required this.postalCode,
    this.amenities,
  });

  @override
  List<Object?> get props => [
    houseDetailId,
    unitId,
    numBedrooms,
    numBathrooms,
    areaSqm,
    propertyType,
    fullAddress,
    city,
    province,
    postalCode,
    amenities,
  ];
}

// lib/domain/entities/unit_image_entity.dart
class UnitImageEntity extends Equatable {
  final int imageId;
  final String imageUrl;
  final bool isThumbnail;

  const UnitImageEntity({
    required this.imageId,
    required this.imageUrl,
    required this.isThumbnail,
  });

  @override
  List<Object?> get props => [imageId, imageUrl, isThumbnail];
}
