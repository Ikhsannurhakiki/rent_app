import 'package:flutter/material.dart';
import '../../common/state_enum.dart';
import '../../data/entities/Unit.dart';
import '../../data/entities/unit_detail_entity.dart';
import '../../data/entities/unit_type_entity.dart';
import '../../data/entities/user_entity.dart';
import '../../data/usecase/get_unit.dart';
import '../../data/usecase/get_unit_detail.dart';
import '../../data/usecase/get_unit_types.dart';
import 'auth_provider.dart';

class UnitNotifier extends ChangeNotifier {
  UserEntity? currentUserEntity;

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

  final AuthProvider authProvider;
  final GetUnitTypes getUnitTypes;
  final GetUnit getRecommendationsUnit;
  final GetUnitDetail getDetailUnit;

  UnitNotifier({
    required this.authProvider,
    required this.getUnitTypes,
    required this.getRecommendationsUnit,
    required this.getDetailUnit,
  });

  // Fetch unit types
  Future<void> fetchUnitTypes() async {
    _unitTypesState = RequestState.Loading;
    notifyListeners();

    final result = await getUnitTypes.execute();
    result.fold(
      (failure) {
        _message = failure.message;
        _unitTypesState = RequestState.Error;
        notifyListeners();
      },
      (unitTypes) {
        _unitTypes = unitTypes;
        _unitTypesState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  // Fetch recommendations
  Future<void> fetchRecommendations({required String apiKey}) async {
    _recommendationUnitsState = RequestState.Loading;
    notifyListeners();

    final result = await getRecommendationsUnit.execute(apiKey: apiKey);

    result.fold(
      (failure) {
        _message = failure.message;
        _recommendationUnitsState = RequestState.Error;
        notifyListeners();
      },
      (unit) {
        _recommendationsUnit = unit;
        _recommendationUnitsState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> fetchDetail({
    required int unitId,
    required String apiKey,
  }) async {
    _detailState = RequestState.Loading;
    notifyListeners();

    final result = await getDetailUnit.execute(unitId: unitId, apiKey: apiKey);

    result.fold(
      (failure) {
        _message = failure.message;
        _detailState = RequestState.Error;
        notifyListeners();
      },
      (unit) {
        _detailUnit = unit;
        _detailState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
