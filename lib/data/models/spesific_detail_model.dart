
import '../entities/specific_detail_entity.dart';

class CarDetailModel {
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

  const CarDetailModel({
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

  factory CarDetailModel.fromJson(Map<String, dynamic> json) {
    return CarDetailModel(
      carDetailId: int.tryParse(json['car_detail_id'].toString()) ?? 0,
      unitId: int.tryParse(json['unit_id'].toString()) ?? 0,
      make: json['make'] ?? '',
      model: json['model'] ?? '',
      year: int.tryParse(json['year'].toString()) ?? 0,
      transmission: json['transmission'] ?? '',
      fuelType: json['fuel_type'] ?? '',
      passengerCapacity: int.tryParse(json['passenger_capacity'].toString()) ?? 0,
      licensePlate: json['license_plate'] ?? '',
      color: json['color'] ?? '',
      subType: json['sub_type'] ?? '',
      engine: json['engine'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
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

  CarDetailEntity toEntity() {
    return CarDetailEntity(
      carDetailId: carDetailId,
      unitId: unitId,
      make: make,
      model: model,
      year: year,
      transmission: transmission,
      fuelType: fuelType,
      passengerCapacity: passengerCapacity,
      licensePlate: licensePlate,
      color: color,
      subType: subType,
      engine: engine,
    );
  }
}

class MotorcycleDetailModel {
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

  const MotorcycleDetailModel({
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

  factory MotorcycleDetailModel.fromJson(Map<String, dynamic> json) {
    return MotorcycleDetailModel(
      motorcycleDetailId: int.tryParse(json['motorcycle_detail_id'].toString()) ?? 0,
      unitId: int.tryParse(json['unit_id'].toString()) ?? 0,
      make: json['make'] ?? '',
      model: json['model'] ?? '',
      year: int.tryParse(json['year'].toString()) ?? 0,
      engineCc: int.tryParse(json['engine_cc'].toString()) ?? 0,
      transmission: json['transmission'] ?? '',
      licensePlate: json['license_plate'] ?? '',
      color: json['color'] ?? '',
      subType: json['sub_type'] ?? '',
      engine: json['engine'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
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

  MotorcycleDetailEntity toEntity() {
    return MotorcycleDetailEntity(
      motorcycleDetailId: motorcycleDetailId,
      unitId: unitId,
      make: make,
      model: model,
      year: year,
      engineCc: engineCc,
      transmission: transmission,
      licensePlate: licensePlate,
      color: color,
      subType: subType,
      engine: engine,
    );
  }
}

class HouseDetailModel {
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

  const HouseDetailModel({
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

  factory HouseDetailModel.fromJson(Map<String, dynamic> json) {
    return HouseDetailModel(
      houseDetailId: int.tryParse(json['house_detail_id'].toString()) ?? 0,
      unitId: int.tryParse(json['unit_id'].toString()) ?? 0,
      numBedrooms: int.tryParse(json['num_bedrooms'].toString()) ?? 0,
      numBathrooms: int.tryParse(json['num_bathrooms'].toString()) ?? 0,
      areaSqm: double.tryParse(json['area_sqm'].toString()) ?? 0.0,
      propertyType: json['property_type'] ?? '',
      fullAddress: json['full_address'] ?? '',
      city: json['city'] ?? '',
      province: json['province'] ?? '',
      postalCode: json['postal_code'] ?? '',
      amenities: json['amenities'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
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

  HouseDetailEntity toEntity() {
    return HouseDetailEntity(
      houseDetailId: houseDetailId,
      unitId: unitId,
      numBedrooms: numBedrooms,
      numBathrooms: numBathrooms,
      areaSqm: areaSqm,
      propertyType: propertyType,
      fullAddress: fullAddress,
      city: city,
      province: province,
      postalCode: postalCode,
      amenities: amenities,
    );
  }
}
