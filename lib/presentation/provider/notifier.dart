import 'package:flutter/material.dart';
import 'package:rent_app/data/usecase/get_unit.dart';

import '../../common/state_enum.dart';
import '../../data/entities/Unit.dart';

class UnitNotifier extends ChangeNotifier {
  var _recommendationsUnit = <Unit>[];

  List<Unit> get recommendationsUnit => _recommendationsUnit;

  RequestState _recommendationUnitsState = RequestState.Empty;
  RequestState get recommendationUnitsState => _recommendationUnitsState;

  String _message = '';

  String get message => _message;

  UnitNotifier({required this.getRecommendationsUnit});
  final GetUnit getRecommendationsUnit;

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

}
