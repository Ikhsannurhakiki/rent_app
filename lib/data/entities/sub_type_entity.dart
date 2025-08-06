import 'package:equatable/equatable.dart';
import 'package:rent_app/data/models/unit_type_model.dart';

import '../models/sub_type_model.dart';

class SubTypeEntity extends Equatable {
  final int subTypeId;
  final String subTypeName;

  const SubTypeEntity({
    required this.subTypeId,
    required this.subTypeName,
  });

  @override
  List<Object> get props => [subTypeId, subTypeName];

  factory SubTypeEntity.fromModel(SubTypeModel model) {
    return SubTypeEntity(
      subTypeId: model.subTypeId,
      subTypeName: model.subTypeName,
    );
  }
}