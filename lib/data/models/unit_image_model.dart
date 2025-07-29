/// Kelas untuk merepresentasikan data gambar unit
class UnitImageModel {
final int imageId;
final String imageUrl;
final bool isThumbnail; // true jika ini gambar thumbnail utama, false jika tidak

UnitImageModel({
required this.imageId,
required this.imageUrl,
required this.isThumbnail,
});

// Factory constructor untuk membuat instance UnitImage dari JSON Map
factory UnitImageModel.fromJson(Map<String, dynamic> json) {
return UnitImageModel(
imageId: int.parse(json['image_id'].toString()), // Pastikan parsing ke int
imageUrl: json['image_url'] as String,
// Konversi nilai '1'/'0' atau true/false dari JSON ke tipe bool Dart
isThumbnail: json['is_thumbnail'].toString() == '1' || json['is_thumbnail'] == true,
);
}
}