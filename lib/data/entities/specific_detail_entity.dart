import 'package:equatable/equatable.dart';

abstract class SpecificDetailsEntity extends Equatable {
  const SpecificDetailsEntity();

  Map<String, dynamic> toJson();
}

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

  const CarDetailEntity({
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

  @override
  Map<String, dynamic> toJson() => {
    'car_detail_id': carDetailId,
    'unit_id': unitId,
    'make': make,
    'model': model,
    'year': year,
    'transmission': transmission,
    'fuel_type': fuelType,
    'passenger_capacity': passengerCapacity,
    'license_plate': licensePlate,
    'color': color,
    'sub_type': subType,
    'engine': engine,
  };
}

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
  final String subType;
  final String engine;

  const MotorcycleDetailEntity({
    required this.motorcycleDetailId,
    required this.unitId,
    required this.make,
    required this.model,
    required this.year,
    required this.engineCc,
    required this.transmission,
    required this.licensePlate,
    required this.color,
    required this.subType,
    required this.engine,
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
    subType,
    engine,
  ];

  @override
  Map<String, dynamic> toJson() => {
    'motorcycle_detail_id': motorcycleDetailId,
    'unit_id': unitId,
    'make': make,
    'model': model,
    'year': year,
    'engine_cc': engineCc,
    'transmission': transmission,
    'license_plate': licensePlate,
    'color': color,
    'sub_type': subType,
    'engine': engine,
  };
}

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

  const HouseDetailEntity({
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

  @override
  Map<String, dynamic> toJson() => {
    'house_detail_id': houseDetailId,
    'unit_id': unitId,
    'num_bedrooms': numBedrooms,
    'num_bathrooms': numBathrooms,
    'area_sqm': areaSqm,
    'property_type': propertyType,
    'full_address': fullAddress,
    'city': city,
    'province': province,
    'postal_code': postalCode,
    'amenities': amenities,
  };
}
