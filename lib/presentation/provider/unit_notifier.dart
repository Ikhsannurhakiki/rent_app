import 'package:flutter/material.dart';
import 'package:rent_app/data/entities/unit_type_entity.dart';
import 'package:rent_app/data/usecase/get_unit.dart';

import '../../common/state_enum.dart';
import '../../data/entities/Unit.dart';
import '../../data/models/specific_detail_entity.dart';
import '../../data/usecase/get_unit_detail.dart';
import '../../data/usecase/get_unit_types.dart';

class UnitNotifier extends ChangeNotifier {
  var _unitTypes = <UnitTypeEntity>[];

  List<UnitTypeEntity> get unitTypes => _unitTypes;
  RequestState _unitTypesState = RequestState.Empty;

  RequestState get unitTypesState => _unitTypesState;

  var _recommendationsUnit = <Unit>[];

  List<Unit> get recommendationsUnit => _recommendationsUnit;
  RequestState _recommendationUnitsState = RequestState.Empty;

  RequestState get recommendationUnitsState => _recommendationUnitsState;

  late UnitDetailEntity _detailUnit;

  UnitDetailEntity get detailUnit => _detailUnit;
  RequestState _detailState = RequestState.Empty;

  RequestState get detailState => _detailState;

  String _message = '';

  String get message => _message;

  UnitNotifier({
    required this.getUnitTypes,
    required this.getRecommendationsUnit,
    required this.getDetailUnit,
  });

  final GetUnitTypes getUnitTypes;
  final GetUnit getRecommendationsUnit;
  final GetUnitDetail getDetailUnit;

  Future<void> fetchUnitTypes() async {
    _unitTypesState = RequestState.Loading;
    notifyListeners();
    final result = await getUnitTypes.execute();
    result.fold(
      (failure) {
        print(failure);
        _message = failure.message;
        _unitTypesState = RequestState.Error;
        notifyListeners();
      },
      (unitTypes) {
        _unitTypesState = RequestState.Loaded;
        _unitTypes = unitTypes;
        print(unitTypes);
        notifyListeners();
      },
    );
  }

  Future<void> fetchRecommendations() async {
    _recommendationUnitsState = RequestState.Loading;
    notifyListeners();

    final result = await getRecommendationsUnit.execute();
    result.fold(
      (failure) {
        print(failure);
        _message = failure.message;
        _recommendationUnitsState = RequestState.Error;
        notifyListeners(); // Tambahkan ini agar UI bisa update saat error
      },
      (unit) {
        _recommendationUnitsState = RequestState.Loaded;
        _recommendationsUnit = unit;
        print(unit);
        notifyListeners();
      },
    );
  }

  Future<void> fetchDetail(int unitId) async {
    _detailState = RequestState.Loading;
    notifyListeners();
    final result = await getDetailUnit.execute(unitId);
    result.fold(
      (failure) {
        print(failure);
        _message = failure.message;
        _detailState = RequestState.Error;
        notifyListeners();
      },
      (unit) {
        _detailState = RequestState.Loaded;
        _detailUnit = unit;
        print(unit);
        notifyListeners();
      },
    );
  }
}
