import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rent_app/data/usecase/getRoadDistanceInKm.dart';

import '../../common/distance_type_enum.dart';
import '../../common/state_enum.dart';

class MapProvider extends ChangeNotifier {
  bool _isMapPicker = true;

  bool get isMapPicker => _isMapPicker;

  Placemark? _placemarkPickUp;

  Placemark? get placemarkPickUp => _placemarkPickUp;

  Placemark? _placemarkReturn;

  Placemark? get placemarkReturn => _placemarkReturn;

  Placemark? _placemarkCurrent;

  Placemark? get placemarkCurrent => _placemarkCurrent;

  Placemark? _placemarkOffice;

  Placemark? get placemarkOffice => _placemarkOffice;

  LatLng? _latLng;
  LatLng? _latLngPickUp;
  LatLng? _latLngReturn;

  LatLng? get latLngPickUp => _latLngPickUp;

  LatLng? get latLngReturn => _latLngReturn;

  LatLng? get latLng => _latLng;

  double _distanceCurrent = 0;
  double _distancePickUp = 0;
  double _distanceReturn = 0;

  double get distanceCurrent => _distanceCurrent;

  double get distancePickUp => _distancePickUp;

  double get distanceReturn => _distanceReturn;

  RequestState _distanceState = RequestState.Empty;
  RequestState _distanceStatePickUp = RequestState.Empty;
  RequestState _distanceStateReturn = RequestState.Empty;

  RequestState get distanceState => _distanceState;
  RequestState get distanceStatePickUp => _distanceStatePickUp;
  RequestState get distanceStateReturn => _distanceStateReturn;

  String _message = '';

  String get message => _message;

  MapProvider({required this.getRoadDistanceInKm});

  final GetRoadDistanceInKm getRoadDistanceInKm;

  void setIsMapPicker(bool isMapPicker) {
    _isMapPicker = isMapPicker;
    notifyListeners();
  }

  void resetIsMapPicker() {
    _isMapPicker = true;
    notifyListeners();
  }

  void setPlacemarkOffice(Placemark placemarkOffice) {
    _placemarkOffice = placemarkOffice;
    notifyListeners();
  }

  void resetPlacemarkOffice() {
    _placemarkOffice = null;
    notifyListeners();
  }

  void setPlacemarkPickUp(Placemark placemarkPickUp) {
    _placemarkPickUp = placemarkPickUp;
    notifyListeners();
  }

  void resetPlacemarkPickUp() {
    _placemarkPickUp = null;
    notifyListeners();
  }

  void setPlacemarkCurrent(Placemark placemarkCurrent) {
    _placemarkCurrent = placemarkCurrent;
    print(_placemarkCurrent);
    notifyListeners();
  }

  void resetPlacemarkCurrent() {
    _placemarkCurrent = null;
    notifyListeners();
  }

  void setPlacemarkReturn(Placemark placemarkReturn) {
    _placemarkReturn = placemarkReturn;
    notifyListeners();
  }

  void resetPlacemarkReturn() {
    _placemarkReturn = null;
    notifyListeners();
  }

  void setLatLngPickUp(LatLng latLngPickUp) {
    _latLngPickUp = latLngPickUp;
    notifyListeners();
  }

  void resetLatLngPickUp() {
    _latLngPickUp = const LatLng(0, 0);
    notifyListeners();
  }

  void setLatLngReturn(LatLng latLngReturn) {
    _latLngReturn = latLngReturn;
    notifyListeners();
  }

  void resetLatLngReturn() {
    _latLngReturn = const LatLng(0, 0);
    notifyListeners();
  }

  Future<List<Placemark>> getPlacemark(LatLng latLng) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );
      return placemarks;
    } catch (e) {
      return [];
    }
  }

  Future<void> getDistance(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
    String apiKey,
    DistanceType type,
  ) async {
    _distanceState = RequestState.Loading;
    notifyListeners();

    final result = await getRoadDistanceInKm.execute(
      startLat,
      startLng,
      endLat,
      endLng,
      apiKey,
    );

    result.fold(
      (failure) {
        print(failure);
        _message = failure.message;
        _distanceState = RequestState.Error;
        notifyListeners();
      },
      (distance) {
        _distanceState = RequestState.Loaded;

        switch (type) {
          case DistanceType.current:
            _distanceCurrent = distance;
            break;
          case DistanceType.pickUp:
            _distancePickUp = distance;
            break;
          case DistanceType.returnPlace:
            _distanceReturn = distance;
            break;
        }

        print("Distance ($type): $distance");
        notifyListeners();
      },
    );
  }
}
