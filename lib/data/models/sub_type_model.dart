
import '../entities/sub_type_entity.dart';

class SubTypeModel {
  final int subTypeId;
  final String subTypeName;

  SubTypeModel({
    required this.subTypeId,
    required this.subTypeName,
  });

  factory SubTypeModel.fromJson(Map<String, dynamic> json) {
    return SubTypeModel(
      subTypeId: int.tryParse(json['sub_type_id']?.toString() ?? '') ?? 0,
      subTypeName: json['sub_type_name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sub_type_id': subTypeId,
      'sub_type_name': subTypeName,
    };
  }

  SubTypeEntity toEntity() {
    return SubTypeEntity(
      subTypeId: subTypeId,
      subTypeName: subTypeName,
    );
  }

  @override
  List<Object> get props => [subTypeId, subTypeName];
}