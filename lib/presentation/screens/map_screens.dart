import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../provider/map_provider.dart';

class MapScreen extends StatefulWidget {
  final bool isPick;

  const MapScreen({super.key, required this.isPick});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Location _locationService = Location();
  GoogleMapController? _mapController;
  LatLng? _currentLatLng;
  Set<Marker> _markers = {};
  geo.Placemark? _placemark;
  MapType _currentMapType = MapType.normal;
  LatLng _currentPosition = const LatLng(-6.200000, 106.816666);

  Future<void> _getMyLocation() async {
    final hasPermission = await _locationService.hasPermission();
    if (hasPermission == PermissionStatus.denied) {
      await _locationService.requestPermission();
    }

    final locationData = await _locationService.getLocation();
    setState(() {
      _currentPosition = LatLng(
        locationData.latitude!,
        locationData.longitude!,
      );
    });

    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(_currentPosition, 16),
    );
  }

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    final mapProvider = context.read<MapProvider>();

    // 1️⃣ Check if pickup or return already set
    bool hasPickup = mapProvider.latLngPickUp != null;
    bool hasReturn = mapProvider.latLngReturn != null;

    LatLng? latLng;
    Placemark? placemark;

    if (widget.isPick && hasPickup) {
      latLng = mapProvider.latLngPickUp;
      placemark = mapProvider.placemarkPickUp;
    } else if (!widget.isPick && hasReturn) {
      latLng = mapProvider.latLngReturn;
      placemark = mapProvider.placemarkReturn;
    } else {
      // 2️⃣ Both are null → use current location
      bool serviceEnabled = await _locationService.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _locationService.requestService();
        if (!serviceEnabled) return;
      }

      PermissionStatus permissionGranted = await _locationService.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await _locationService.requestPermission();
        if (permissionGranted != PermissionStatus.granted) return;
      }

      final locationData = await _locationService.getLocation();
      if (locationData.latitude == null || locationData.longitude == null) return;

      latLng = LatLng(locationData.latitude!, locationData.longitude!);

      final placemarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      if (placemarks.isNotEmpty) {
        placemark = placemarks.first;

        if (widget.isPick) {
          mapProvider.setLatLngPickUp(latLng);
          mapProvider.setPlacemarkPickUp(placemark);
        } else {
          mapProvider.setLatLngReturn(latLng);
          mapProvider.setPlacemarkReturn(placemark);
        }
      }
    }

    // 3️⃣ Update marker & map
    if (latLng != null) {
      setState(() {
        _currentLatLng = latLng;
        _placemark = placemark;

        _markers = {
          Marker(
            markerId: MarkerId(widget.isPick ? "pickup_location" : "return_location"),
            position: latLng!,
            infoWindow: InfoWindow(
              title: placemark?.street ??
                  (widget.isPick ? "Pickup Location" : "Return Location"),
            ),
          ),
        };
      });

      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(latLng, 16),
      );
    }
  }


  Future<void> _onTapMap(LatLng latLng) async {
    try {
      final placemarks = await geo.placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );

      final place = placemarks.first;

      setState(() {
        _currentLatLng = latLng;
        _placemark = place;
        _markers = {
          Marker(
            markerId: const MarkerId("selected"),
            position: latLng,
            infoWindow: const InfoWindow(title: "Selected Location"),
          ),
        };
      });

      _mapController?.animateCamera(CameraUpdate.newLatLngZoom(latLng, 16));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to fetch location details.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mapProvider = context.read<MapProvider>();
    return Scaffold(
      body: _currentLatLng == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _currentLatLng!,
                    zoom: 16,
                  ),
                  markers: _markers,
                  myLocationEnabled: true,
                  mapType: _currentMapType,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  onMapCreated: (controller) => _mapController = controller,
                  onTap: _onTapMap,
                ),
                Positioned(
                  bottom: _placemark != null ? 200 : 20,
                  right: 16,
                  child: Row(
                    children: [
                      FloatingActionButton(
                        heroTag: 'btn_my_location',
                        mini: true,
                        onPressed: _getMyLocation,
                        tooltip: 'My Location',
                        child: Icon(
                          Icons.my_location,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                      FloatingActionButton.small(
                        onPressed: null,
                        child: PopupMenuButton<MapType>(
                          offset: const Offset(0, 54),
                          icon: Icon(
                            Icons.layers_outlined,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                          onSelected: (MapType item) {
                            setState(() {
                              _currentMapType = item;
                            });
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<MapType>>[
                                const PopupMenuItem<MapType>(
                                  value: MapType.normal,
                                  child: Text('Normal'),
                                ),
                                const PopupMenuItem<MapType>(
                                  value: MapType.satellite,
                                  child: Text('Satellite'),
                                ),
                                const PopupMenuItem<MapType>(
                                  value: MapType.terrain,
                                  child: Text('Terrain'),
                                ),
                                const PopupMenuItem<MapType>(
                                  value: MapType.hybrid,
                                  child: Text('Hybrid'),
                                ),
                              ],
                        ),
                      ),
                      FloatingActionButton.small(
                        heroTag: "zoom-in",
                        onPressed: () {
                          _mapController?.animateCamera(CameraUpdate.zoomIn());
                        },
                        child: Icon(
                          Icons.add,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                      FloatingActionButton.small(
                        heroTag: "zoom-out",
                        onPressed: () {
                          _mapController?.animateCamera(CameraUpdate.zoomOut());
                        },
                        child: Icon(
                          Icons.remove,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (_placemark != null)
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _placemark!.street ?? "Unknown street",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${_placemark!.subLocality ?? ""}, '
                              '${_placemark!.locality ?? ""}, '
                              '${_placemark!.subAdministrativeArea ?? ""}, '
                              '${_placemark!.administrativeArea ?? ""}, '
                              '${_placemark!.postalCode ?? ""}, '
                              '${_placemark!.country ?? ""}',
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: OutlinedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.cancel_outlined,
                                          color: Colors.grey,
                                        ),
                                        const Text(
                                          "Cancel",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  flex: 3,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(
                                        context,
                                      ).primaryColor,
                                    ),
                                    onPressed: () {
                                      if (_currentLatLng != null &&
                                          _placemark != null) {
                                        widget.isPick
                                            ? {
                                                mapProvider.setLatLngPickUp(
                                                  _currentLatLng!,
                                                ),
                                                mapProvider.setPlacemarkPickUp(
                                                  _placemark!,
                                                ),
                                              }
                                            : {
                                                mapProvider.setLatLngReturn(
                                                  _currentLatLng!,
                                                ),
                                                mapProvider.setPlacemarkReturn(
                                                  _placemark!,
                                                ),
                                              };
                                        Navigator.pop(context);
                                      } else {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Please tap the map to select a location",
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_location_outlined,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSecondary,
                                        ),
                                        Text(
                                          widget.isPick
                                              ? " Set Pick Point"
                                              : " Set Return Point",
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onSecondary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
