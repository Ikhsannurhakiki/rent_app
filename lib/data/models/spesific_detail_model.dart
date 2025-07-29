abstract class SpecificDetails {}

/// Kelas untuk detail spesifik Mobil
class CarDetailModel implements SpecificDetails {
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

  CarDetailModel({
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
  });

  factory CarDetailModel.fromJson(Map<String, dynamic> json) {
    return CarDetailModel(
      carDetailId: int.parse(json['car_detail_id'].toString()),
      unitId: int.parse(json['unit_id'].toString()),
      make: json['make'] as String,
      model: json['model'] as String,
      year: int.parse(json['year'].toString()),
      transmission: json['transmission'] as String,
      fuelType: json['fuel_type'] as String,
      passengerCapacity: int.parse(json['passenger_capacity'].toString()),
      licensePlate: json['license_plate'] as String,
      color: json['color'] as String,
    );
  }
}

/// Kelas untuk detail spesifik Motor
class MotorcycleDetailModel implements SpecificDetails {
  final int motorcycleDetailId;
  final int unitId;
  final String make;
  final String model;
  final int year;
  final int engineCc;
  final String transmission;
  final String licensePlate;
  final String color;

  MotorcycleDetailModel({
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

  factory MotorcycleDetailModel.fromJson(Map<String, dynamic> json) {
    return MotorcycleDetailModel(
      motorcycleDetailId: int.parse(json['motorcycle_detail_id'].toString()),
      unitId: int.parse(json['unit_id'].toString()),
      make: json['make'] as String,
      model: json['model'] as String,
      year: int.parse(json['year'].toString()),
      engineCc: int.parse(json['engine_cc'].toString()),
      transmission: json['transmission'] as String,
      licensePlate: json['license_plate'] as String,
      color: json['color'] as String,
    );
  }
}

/// Kelas untuk detail spesifik Rumah
class HouseDetailModel implements SpecificDetails {
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
  final String? amenities; // Jika amenities disimpan sebagai JSON string

  HouseDetailModel({
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
      houseDetailId: int.parse(json['house_detail_id'].toString()),
      unitId: int.parse(json['unit_id'].toString()),
      numBedrooms: int.parse(json['num_bedrooms'].toString()),
      numBathrooms: int.parse(json['num_bathrooms'].toString()),
      areaSqm: double.parse(json['area_sqm'].toString()),
      propertyType: json['property_type'] as String,
      fullAddress: json['full_address'] as String,
      city: json['city'] as String,
      province: json['province'] as String,
      postalCode: json['postal_code'] as String,
      amenities: json['amenities'] as String?,
    );
  }
}