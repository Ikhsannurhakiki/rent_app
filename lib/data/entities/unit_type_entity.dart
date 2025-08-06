import 'package:equatable/equatable.dart';
import 'package:rent_app/data/entities/sub_type_entity.dart';
import 'package:rent_app/data/models/unit_type_model.dart';

class UnitTypeEntity extends Equatable {
  final int unitTypeId;
  final String typeName;
  final String? iconName;
  final List<SubTypeEntity> subTypes;

  const UnitTypeEntity({
    required this.unitTypeId,
    required this.typeName,
    this.iconName,
    required this.subTypes,
  });

  @override
  List<Object?> get props => [unitTypeId, typeName, iconName, subTypes];

  factory UnitTypeEntity.fromModel(UnitTypeModel model) {
    return UnitTypeEntity(
      unitTypeId: model.unitTypeId,
      typeName: model.typeName,
      iconName: model.iconName,
      subTypes: model.subTypes.map((subTypeModel) => SubTypeEntity.fromModel(subTypeModel)).toList(),
    );
  }
}