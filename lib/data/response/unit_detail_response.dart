import 'package:equatable/equatable.dart';
import 'package:rent_app/data/models/unit_detail_model.dart';

class UnitDetailResponse extends Equatable {
  final UnitDetailModel detail;

  const UnitDetailResponse({required this.detail});

  factory UnitDetailResponse.fromJson(Map<String, dynamic> json) {
    if (json['status'] != 'success') {
      throw Exception('API response status is not success: ${json['message']}');
    }

    return UnitDetailResponse(
      detail: UnitDetailModel.fromJson(json["data"] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": "success",
    "data": detail.toJson(),
  };

  @override
  List<Object> get props => [detail];
}