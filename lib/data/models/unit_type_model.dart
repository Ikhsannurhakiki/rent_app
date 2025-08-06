
import 'package:rent_app/data/models/sub_type_model.dart';

import '../entities/unit_type_entity.dart';

class UnitTypeModel {
  final int unitTypeId;
  final String typeName;
  final String? iconName;
  final List<SubTypeModel> subTypes;

  UnitTypeModel({
    required this.unitTypeId,
    required this.typeName,
    this.iconName,
    required this.subTypes,
  });

  factory UnitTypeModel.fromJson(Map<String, dynamic> json) {
    final subTypesJson = json['sub_types'] as List<dynamic>?;
    final subTypes = subTypesJson != null
        ? subTypesJson.map((e) => SubTypeModel.fromJson(e as Map<String, dynamic>)).toList()
        : <SubTypeModel>[];

    return UnitTypeModel(
      unitTypeId: int.tryParse(json['unit_type_id']?.toString() ?? '') ?? 0,
      typeName: json['type_name'] as String,
      iconName: json['icon_name'] as String?,
      subTypes: subTypes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unit_type_id': unitTypeId,
      'type_name': typeName,
      'icon_name': iconName,
      'sub_types': subTypes.map((e) => e.toJson()).toList(),
    };
  }

  UnitTypeEntity toEntity() {
    return UnitTypeEntity(
      unitTypeId: unitTypeId,
      typeName: typeName,
      iconName: iconName,
      subTypes: subTypes.map((model) => model.toEntity()).toList(),
    );
  }


  @override
  List<Object?> get props => [unitTypeId, typeName, iconName, subTypes];
}