import '../entities/unit_image_entity.dart';

class UnitImageModel {
  final int imageId;
  final String imageUrl;
  final bool
  isThumbnail;

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
          json['is_thumbnail'].toString() == '1' ||
          json['is_thumbnail'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image_id': imageId,
      'image_url': imageUrl,
      'is_thumbnail': isThumbnail ? 1 : 0,
    };
  }

  UnitImageEntity toEntity() {
    return UnitImageEntity(
      imageId: imageId,
      imageUrl: imageUrl,
      isThumbnail: isThumbnail,
    );
  }
}
