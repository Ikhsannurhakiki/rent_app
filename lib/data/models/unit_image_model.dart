/// Kelas untuk merepresentasikan data gambar unit
class UnitImageModel {
  final int imageId;
  final String imageUrl;
  final bool
  isThumbnail; // true jika ini gambar thumbnail utama, false jika tidak

  UnitImageModel({
    required this.imageId,
    required this.imageUrl,
    required this.isThumbnail,
  });

  // Factory constructor untuk membuat instance UnitImageModel dari JSON Map
  factory UnitImageModel.fromJson(Map<String, dynamic> json) {
    return UnitImageModel(
      // Menggunakan tryParse untuk keamanan
      imageId: int.tryParse(json['image_id']?.toString() ?? '') ?? 0,
      imageUrl: json['image_url'] as String,
      // Konversi nilai '1'/'0' atau true/false dari JSON ke tipe bool Dart
      isThumbnail:
      json['is_thumbnail'].toString() == '1' || json['is_thumbnail'] == true,
    );
  }

  // Tambahkan metode toJson() untuk UnitImageModel
  Map<String, dynamic> toJson() {
    return {
      'image_id': imageId,
      'image_url': imageUrl,
      // Konversi boolean ke integer (1 atau 0) yang sering digunakan di database
      'is_thumbnail': isThumbnail ? 1 : 0,
    };
  }
}