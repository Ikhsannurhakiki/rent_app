// Pastikan semua impor sudah benar
import 'package:equatable/equatable.dart';
import 'package:rent_app/data/models/specific_detail_entity.dart';


// Kelas utama untuk merepresentasikan semua data detail unit
class UnitDetailModel extends Equatable {
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

  final SpecificDetails? specificDetails;
  final List<UnitImageModel> images;

  const UnitDetailModel({
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
          break;
      }
    }

    return UnitDetailModel(
      unitId: int.tryParse(json['unit_id']?.toString() ?? '') ?? 0,
      ownerId: int.tryParse(json['owner_id']?.toString() ?? '') ?? 0,
      unitType: json['unit_type'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      dailyRate: double.tryParse(json['daily_rate']?.toString() ?? '') ?? 0.0,
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

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'unit_id': unitId,
      'owner_id': ownerId,
      'unit_type': unitType,
      'name': name,
      'description': description,
      'daily_rate': dailyRate,
      'currency': currency,
      'location': location,
      'availability_status': availabilityStatus,
      'thumbnail_image_url': thumbnailImageUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'images': images.map((image) => image.toJson()).toList(),
    };

    if (specificDetails != null) {
      if (specificDetails is CarDetailModel) {
        json['specific_details'] = (specificDetails as CarDetailModel).toJson();
      } else if (specificDetails is MotorcycleDetailModel) {
        json['specific_details'] = (specificDetails as MotorcycleDetailModel).toJson();
      } else if (specificDetails is HouseDetailModel) {
        json['specific_details'] = (specificDetails as HouseDetailModel).toJson();
      }
    } else {
      json['specific_details'] = {};
    }

    return json;
  }

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

  // ======================================
  // Tambahkan metode toEntity() di sini
  // ======================================
  UnitDetailEntity toEntity() {
    SpecificDetailsEntity? entitySpecificDetails;
    if (specificDetails != null) {
      if (specificDetails is CarDetailModel) {
        entitySpecificDetails = (specificDetails as CarDetailModel).toEntity();
      } else if (specificDetails is MotorcycleDetailModel) {
        entitySpecificDetails = (specificDetails as MotorcycleDetailModel).toEntity();
      } else if (specificDetails is HouseDetailModel) {
        entitySpecificDetails = (specificDetails as HouseDetailModel).toEntity();
      }
    }

    return UnitDetailEntity(
      unitId: unitId,
      ownerId: ownerId,
      unitType: unitType,
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
    );
  }
}

// Abstract class untuk detail spesifik
abstract class SpecificDetails extends Equatable {
  Map<String, dynamic> toJson();
  SpecificDetailsEntity toEntity(); // Tambahkan deklarasi toEntity
  @override
  List<Object?> get props;
}

// Kelas untuk detail spesifik Mobil
class CarDetailModel extends SpecificDetails {
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

  @override
  List<Object?> get props => [
    carDetailId, unitId, make, model, year,
    transmission, fuelType, passengerCapacity, licensePlate, color,
  ];

  // ======================================
  // Tambahkan metode toEntity() di sini
  // ======================================
  @override
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
    );
  }
}

// Kelas untuk detail spesifik Motor
class MotorcycleDetailModel extends SpecificDetails {
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

  @override
  List<Object?> get props => [
    motorcycleDetailId, unitId, make, model, year,
    engineCc, transmission, licensePlate, color,
  ];

  // ======================================
  // Tambahkan metode toEntity() di sini
  // ======================================
  @override
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
    );
  }
}

// Kelas untuk detail spesifik Rumah
class HouseDetailModel extends SpecificDetails {
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

  @override
  List<Object?> get props => [
    houseDetailId, unitId, numBedrooms, numBathrooms, areaSqm,
    propertyType, fullAddress, city, province, postalCode, amenities,
  ];

  // ======================================
  // Tambahkan metode toEntity() di sini
  // ======================================
  @override
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

// Kelas untuk detail gambar unit
class UnitImageModel extends Equatable {
  final int imageId;
  final String imageUrl;
  final bool isThumbnail;

  const UnitImageModel({
    required this.imageId,
    required this.imageUrl,
    required this.isThumbnail,
  });

  factory UnitImageModel.fromJson(Map<String, dynamic> json) {
    return UnitImageModel(
      imageId: int.tryParse(json['image_id']?.toString() ?? '') ?? 0,
      imageUrl: json['image_url'] as String,
      isThumbnail:
      json['is_thumbnail'].toString() == '1' || json['is_thumbnail'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image_id': imageId,
      'image_url': imageUrl,
      'is_thumbnail': isThumbnail ? 1 : 0,
    };
  }

  @override
  List<Object?> get props => [imageId, imageUrl, isThumbnail];

  // ======================================
  // Tambahkan metode toEntity() di sini
  // ======================================
  UnitImageEntity toEntity() {
    return UnitImageEntity(
      imageId: imageId,
      imageUrl: imageUrl,
      isThumbnail: isThumbnail,
    );
  }
}