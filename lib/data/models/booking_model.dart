

import '../entities/booking_entity.dart';

class BookingModel extends BookingEntity {
  BookingModel({
    required super.bookingId,
    required super.unitId,
    required super.userId,
    required super.startDate,
    required super.endDate,
    required super.dailyRateAtBooking,
    required super.totalPrice,
    super.deliveryFee,
    required super.status,
    super.pickupLat,
    super.pickupLng,
    super.dropoffLat,
    super.dropoffLng,
    required super.createdAt,
    required super.updatedAt,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      bookingId: json['booking_id'],
      unitId: json['unit_id'],
      userId: json['user_id'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      dailyRateAtBooking: (json['daily_rate_at_booking'] as num).toDouble(),
      totalPrice: (json['total_price'] as num).toDouble(),
      deliveryFee: json['delivery_fee'] != null
          ? (json['delivery_fee'] as num).toDouble()
          : null,
      status: json['status'],
      pickupLat: json['pickup_lat'] != null
          ? (json['pickup_lat'] as num).toDouble()
          : null,
      pickupLng: json['pickup_lng'] != null
          ? (json['pickup_lng'] as num).toDouble()
          : null,
      dropoffLat: json['dropoff_lat'] != null
          ? (json['dropoff_lat'] as num).toDouble()
          : null,
      dropoffLng: json['dropoff_lng'] != null
          ? (json['dropoff_lng'] as num).toDouble()
          : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    "booking_id": bookingId,
    "unit_id": unitId,
    "user_id": userId,
    "start_date": startDate.toIso8601String(),
    "end_date": endDate.toIso8601String(),
    "daily_rate_at_booking": dailyRateAtBooking,
    "total_price": totalPrice,
    "delivery_fee": deliveryFee,
    "status": status,
    "pickup_lat": pickupLat,
    "pickup_lng": pickupLng,
    "dropoff_lat": dropoffLat,
    "dropoff_lng": dropoffLng,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
