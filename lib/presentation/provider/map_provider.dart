import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapProvider extends ChangeNotifier {
  bool _isMapPicker = true;
  bool get isMapPicker => _isMapPicker;
  Placemark? _placemarkPickUp;
  Placemark? get placemarkPickUp => _placemarkPickUp;
  Placemark? _placemarkReturn;
  Placemark? get placemarkReturn => _placemarkReturn;
  Placemark? _placemarkCurrent;
  Placemark? get placemarkCurrent => _placemarkCurrent;
  LatLng? _latLng;
  LatLng? _latLngPickUp;
  LatLng? _latLngReturn;
  LatLng? get latLngPickUp => _latLngPickUp;
  LatLng? get latLngReturn => _latLngReturn;
  LatLng? get latLng => _latLng;

  void setIsMapPicker(bool isMapPicker) {
    _isMapPicker = isMapPicker;
    notifyListeners();
  }

  void resetIsMapPicker() {
    _isMapPicker = true;
    notifyListeners();
  }

  void setPlacemarkPickUp(Placemark placemarkPickUp) {
    _placemarkPickUp = placemarkPickUp;
    print(_placemarkPickUp);
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
}
