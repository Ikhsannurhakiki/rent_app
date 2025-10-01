
class BookingEntity {
  final int bookingId;
  final int unitId;
  final int userId;
  final DateTime startDate;
  final DateTime endDate;
  final double dailyRateAtBooking;
  final double totalPrice;
  final double? deliveryFee;
  final String status;
  final double? pickupLat;
  final double? pickupLng;
  final double? dropoffLat;
  final double? dropoffLng;
  final DateTime createdAt;
  final DateTime updatedAt;

  BookingEntity({
    required this.bookingId,
    required this.unitId,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.dailyRateAtBooking,
    required this.totalPrice,
    this.deliveryFee,
    required this.status,
    this.pickupLat,
    this.pickupLng,
    this.dropoffLat,
    this.dropoffLng,
    required this.createdAt,
    required this.updatedAt,
  });
}
