import 'package:equatable/equatable.dart';
import 'package:rent_app/data/models/unit_model.dart';

class UnitResponse extends Equatable {
  final List<UnitModel> list;

  UnitResponse({required this.list});

  factory UnitResponse.fromJson(Map<String, dynamic> json) => UnitResponse(
    list: List<UnitModel>.from(
      (json["data"] as List)
          .map((x) => UnitModel.fromJson(x)),
    ),
  );


  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(list.map((x) => x.toJson())),
  };

  @override
  List<Object> get props => [list];
}
