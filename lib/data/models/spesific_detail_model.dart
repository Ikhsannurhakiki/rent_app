/// Abstract class untuk detail spesifik
abstract class SpecificDetails {
  // Deklarasi metode toJson() yang harus diimplementasikan oleh setiap subclass
  Map<String, dynamic> toJson();
}

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
  final String licensePlate; // Berdasarkan kode Anda, ini required
  final String color; // Berdasarkan kode Anda, ini required

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
      carDetailId: int.tryParse(json['car_detail_id']?.toString() ?? '') ?? 0,
      unitId: int.tryParse(json['unit_id']?.toString() ?? '') ?? 0,
      make: json['make'] as String,
      model: json['model'] as String,
      year: int.tryParse(json['year']?.toString() ?? '') ?? 0,
      transmission: json['transmission'] as String,
      fuelType: json['fuel_type'] as String,
      passengerCapacity: int.tryParse(json['passenger_capacity']?.toString() ?? '') ?? 0,
      licensePlate: json['license_plate'] as String,
      color: json['color'] as String,
    );
  }

  // Implementasi metode toJson() untuk CarDetailModel
  @override
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
    };
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
  final String licensePlate; // Berdasarkan kode Anda, ini required
  final String color; // Berdasarkan kode Anda, ini required

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
      motorcycleDetailId: int.tryParse(json['motorcycle_detail_id']?.toString() ?? '') ?? 0,
      unitId: int.tryParse(json['unit_id']?.toString() ?? '') ?? 0,
      make: json['make'] as String,
      model: json['model'] as String,
      year: int.tryParse(json['year']?.toString() ?? '') ?? 0,
      engineCc: int.tryParse(json['engine_cc']?.toString() ?? '') ?? 0,
      transmission: json['transmission'] as String,
      licensePlate: json['license_plate'] as String,
      color: json['color'] as String,
    );
  }

  // Implementasi metode toJson() untuk MotorcycleDetailModel
  @override
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
    };
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
  final String? amenities; // Bisa nullable

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
      houseDetailId: int.tryParse(json['house_detail_id']?.toString() ?? '') ?? 0,
      unitId: int.tryParse(json['unit_id']?.toString() ?? '') ?? 0,
      numBedrooms: int.tryParse(json['num_bedrooms']?.toString() ?? '') ?? 0,
      numBathrooms: int.tryParse(json['num_bathrooms']?.toString() ?? '') ?? 0,
      areaSqm: double.tryParse(json['area_sqm']?.toString() ?? '') ?? 0.0,
      propertyType: json['property_type'] as String,
      fullAddress: json['full_address'] as String,
      city: json['city'] as String,
      province: json['province'] as String,
      postalCode: json['postal_code'] as String,
      amenities: json['amenities'] as String?,
    );
  }

  // Implementasi metode toJson() untuk HouseDetailModel
  @override
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
}