import 'package:flutter/material.dart';
import 'package:rent_app/data/usecase/get_unit.dart';

import '../../common/state_enum.dart';
import '../../data/entities/Unit.dart';
import '../../data/models/specific_detail_entity.dart';
import '../../data/usecase/get_unit_detail.dart';

class UnitNotifier extends ChangeNotifier {
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
    required this.getRecommendationsUnit,
    required this.getDetailUnit,
  });

  final GetUnit getRecommendationsUnit;
  final GetUnitDetail getDetailUnit;

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
