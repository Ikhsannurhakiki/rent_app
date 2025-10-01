
class RatingEntity {
  final int ratingId;
  final int bookingId;
  final int unitId;
  final int userId;
  final int rating; // 1 - 5
  final String? feedback;
  final DateTime createdAt;
  final DateTime updatedAt;

  RatingEntity({
    required this.ratingId,
    required this.bookingId,
    required this.unitId,
    required this.userId,
    required this.rating,
    this.feedback,
    required this.createdAt,
    required this.updatedAt,
  });
}
