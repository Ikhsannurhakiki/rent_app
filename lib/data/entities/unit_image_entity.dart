import 'package:equatable/equatable.dart';

class UnitImageEntity extends Equatable {
  final int imageId;
  final String imageUrl;
  final bool isThumbnail;

  const UnitImageEntity({
    required this.imageId,
    required this.imageUrl,
    required this.isThumbnail,
  });

  @override
  List<Object?> get props => [imageId, imageUrl, isThumbnail];
}
