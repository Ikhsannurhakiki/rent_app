
import '../entities/rating_entity.dart';

class RatingModel extends RatingEntity {
  RatingModel({
    required super.ratingId,
    required super.bookingId,
    required super.unitId,
    required super.userId,
    required super.rating,
    super.feedback,
    required super.createdAt,
    required super.updatedAt,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      ratingId: json['rating_id'],
      bookingId: json['booking_id'],
      unitId: json['unit_id'],
      userId: json['user_id'],
      rating: json['rating'],
      feedback: json['feedback'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    "rating_id": ratingId,
    "booking_id": bookingId,
    "unit_id": unitId,
    "user_id": userId,
    "rating": rating,
    "feedback": feedback,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
